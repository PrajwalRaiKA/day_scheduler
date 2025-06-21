import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'di/di.dart';
import 'features/goals/presentation/bloc/goals_bloc.dart';
import 'features/todos/presentation/bloc/todos_bloc.dart';
import 'features/schedule/presentation/bloc/schedule_bloc.dart';
import 'features/goals/presentation/widgets/goals_section.dart';
import 'features/todos/presentation/widgets/todos_section.dart';
import 'features/schedule/presentation/widgets/schedule_section.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GoalsBloc>(
          create: (context) => getIt<GoalsBloc>(),
        ),
        BlocProvider<TodosBloc>(
          create: (context) => getIt<TodosBloc>(),
        ),
        BlocProvider<ScheduleBloc>(
          create: (context) => getIt<ScheduleBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Day Scheduler',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const LandingPage(),
      ),
    );
  }
}

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _dispatchLoadEvents();
  }

  void _dispatchLoadEvents() {
    context.read<GoalsBloc>().add(LoadGoalsEvent(_selectedDate));
    context.read<TodosBloc>().add(LoadTodosEvent(_selectedDate));
    context.read<ScheduleBloc>().add(LoadScheduleEvent(_selectedDate));
  }

  Future<void> _pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      _dispatchLoadEvents();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Day Scheduler')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Selected Date: '
                  '${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                ElevatedButton(
                  onPressed: () => _pickDate(context),
                  child: const Text('Pick Date'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                GoalsSection(selectedDate: _selectedDate),
                TodosSection(selectedDate: _selectedDate),
                ScheduleSection(selectedDate: _selectedDate),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
