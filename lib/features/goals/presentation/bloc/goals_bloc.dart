import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/goal.dart';
import '../../domain/usecases/goal_usecases.dart';
import 'package:equatable/equatable.dart';

part 'goals_event.dart';
part 'goals_state.dart';

class GoalsBloc extends Bloc<GoalsEvent, GoalsState> {
  final GetGoalsByDate getGoalsByDate;
  final AddGoal addGoal;
  final UpdateGoal updateGoal;
  final DeleteGoal deleteGoal;

  GoalsBloc({
    required this.getGoalsByDate,
    required this.addGoal,
    required this.updateGoal,
    required this.deleteGoal,
  }) : super(GoalsInitial()) {
    on<LoadGoalsEvent>((event, emit) async {
      emit(GoalsLoading());
      try {
        final goals = await getGoalsByDate(event.date);
        emit(GoalsLoaded(goals));
      } catch (e) {
        emit(GoalsError(e.toString()));
      }
    });
    on<AddGoalEvent>((event, emit) async {
      try {
        await addGoal(event.goal);
        add(LoadGoalsEvent(event.goal.date));
      } catch (e) {
        emit(GoalsError(e.toString()));
      }
    });
    on<UpdateGoalEvent>((event, emit) async {
      try {
        await updateGoal(event.goal);
        add(LoadGoalsEvent(event.goal.date));
      } catch (e) {
        emit(GoalsError(e.toString()));
      }
    });
    on<DeleteGoalEvent>((event, emit) async {
      try {
        await deleteGoal(event.goalId);
        add(LoadGoalsEvent(event.date));
      } catch (e) {
        emit(GoalsError(e.toString()));
      }
    });
  }
} 