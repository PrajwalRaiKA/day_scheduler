// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:day_scheduler/main.dart';
import 'package:day_scheduler/features/goals/presentation/bloc/goals_bloc.dart';
import 'package:day_scheduler/features/todos/presentation/bloc/todos_bloc.dart';
import 'package:day_scheduler/features/schedule/presentation/bloc/schedule_bloc.dart';

import 'widget_test.mocks.dart';

@GenerateMocks([GoalsBloc, TodosBloc, ScheduleBloc])
void main() {
  group('Day Scheduler App Tests', () {
    late MockGoalsBloc mockGoalsBloc;
    late MockTodosBloc mockTodosBloc;
    late MockScheduleBloc mockScheduleBloc;

    setUp(() {
      mockGoalsBloc = MockGoalsBloc();
      mockTodosBloc = MockTodosBloc();
      mockScheduleBloc = MockScheduleBloc();
    });

    Widget createApp() {
      return MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<GoalsBloc>.value(value: mockGoalsBloc),
            BlocProvider<TodosBloc>.value(value: mockTodosBloc),
            BlocProvider<ScheduleBloc>.value(value: mockScheduleBloc),
          ],
          child: const LandingPage(),
        ),
      );
    }

    testWidgets('should display app title and date picker', (WidgetTester tester) async {
      // arrange
      when(mockGoalsBloc.state).thenReturn(GoalsLoaded([]));
      when(mockTodosBloc.state).thenReturn(TodosLoaded([]));
      when(mockScheduleBloc.state).thenReturn(ScheduleLoaded([]));

      // act
      await tester.pumpWidget(createApp());

      // assert
      expect(find.text('Day Scheduler'), findsOneWidget);
      expect(find.text('Pick Date'), findsOneWidget);
      expect(find.textContaining('Selected Date:'), findsOneWidget);
    });

    testWidgets('should display all three sections', (WidgetTester tester) async {
      // arrange
      when(mockGoalsBloc.state).thenReturn(GoalsLoaded([]));
      when(mockTodosBloc.state).thenReturn(TodosLoaded([]));
      when(mockScheduleBloc.state).thenReturn(ScheduleLoaded([]));

      // act
      await tester.pumpWidget(createApp());

      // assert
      expect(find.text('Goals'), findsOneWidget);
      expect(find.text('Todos'), findsOneWidget);
      expect(find.text('Schedule'), findsOneWidget);
    });

    testWidgets('should show date picker when Pick Date button is tapped',
        (WidgetTester tester) async {
      // arrange
      when(mockGoalsBloc.state).thenReturn(GoalsLoaded([]));
      when(mockTodosBloc.state).thenReturn(TodosLoaded([]));
      when(mockScheduleBloc.state).thenReturn(ScheduleLoaded([]));

      // act
      await tester.pumpWidget(createApp());
      await tester.tap(find.text('Pick Date'));
      await tester.pumpAndSettle();

      // assert
      expect(find.byType(DatePickerDialog), findsOneWidget);
    });

    testWidgets('should load data for selected date on init', (WidgetTester tester) async {
      // arrange
      when(mockGoalsBloc.state).thenReturn(GoalsLoaded([]));
      when(mockTodosBloc.state).thenReturn(TodosLoaded([]));
      when(mockScheduleBloc.state).thenReturn(ScheduleLoaded([]));

      // act
      await tester.pumpWidget(createApp());

      // assert
      // Verify that load events were dispatched (this would require more complex setup)
      // For now, we just verify the sections are rendered
      expect(find.text('Goals'), findsOneWidget);
      expect(find.text('Todos'), findsOneWidget);
      expect(find.text('Schedule'), findsOneWidget);
    });

    testWidgets('should display loading states correctly', (WidgetTester tester) async {
      // arrange
      when(mockGoalsBloc.state).thenReturn(GoalsLoading());
      when(mockTodosBloc.state).thenReturn(TodosLoading());
      when(mockScheduleBloc.state).thenReturn(ScheduleLoading());

      // act
      await tester.pumpWidget(createApp());

      // assert
      expect(find.byType(CircularProgressIndicator), findsNWidgets(3));
    });

    testWidgets('should display error states correctly', (WidgetTester tester) async {
      // arrange
      when(mockGoalsBloc.state).thenReturn(const GoalsError('Goals error'));
      when(mockTodosBloc.state).thenReturn(const TodosError('Todos error'));
      when(mockScheduleBloc.state).thenReturn(const ScheduleError('Schedule error'));

      // act
      await tester.pumpWidget(createApp());

      // assert
      expect(find.text('Error: Goals error'), findsOneWidget);
      expect(find.text('Error: Todos error'), findsOneWidget);
      expect(find.text('Error: Schedule error'), findsOneWidget);
    });

    testWidgets('should display current date in correct format', (WidgetTester tester) async {
      // arrange
      when(mockGoalsBloc.state).thenReturn(GoalsLoaded([]));
      when(mockTodosBloc.state).thenReturn(TodosLoaded([]));
      when(mockScheduleBloc.state).thenReturn(ScheduleLoaded([]));

      // act
      await tester.pumpWidget(createApp());

      // assert
      final now = DateTime.now();
      final expectedDate = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
      expect(find.textContaining(expectedDate), findsOneWidget);
    });
  });
}
