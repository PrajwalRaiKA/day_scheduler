part of 'goals_bloc.dart';

abstract class GoalsEvent extends Equatable {
  const GoalsEvent();
  @override
  List<Object?> get props => [];
}

class LoadGoalsEvent extends GoalsEvent {
  final DateTime date;
  const LoadGoalsEvent(this.date);
  @override
  List<Object?> get props => [date];
}

class AddGoalEvent extends GoalsEvent {
  final Goal goal;
  const AddGoalEvent(this.goal);
  @override
  List<Object?> get props => [goal];
}

class UpdateGoalEvent extends GoalsEvent {
  final Goal goal;
  const UpdateGoalEvent(this.goal);
  @override
  List<Object?> get props => [goal];
}

class DeleteGoalEvent extends GoalsEvent {
  final String goalId;
  final DateTime date;
  const DeleteGoalEvent(this.goalId, this.date);
  @override
  List<Object?> get props => [goalId, date];
} 