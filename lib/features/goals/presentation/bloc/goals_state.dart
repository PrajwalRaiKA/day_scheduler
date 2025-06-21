part of 'goals_bloc.dart';

abstract class GoalsState extends Equatable {
  const GoalsState();
  @override
  List<Object?> get props => [];
}

class GoalsInitial extends GoalsState {}
class GoalsLoading extends GoalsState {}
class GoalsLoaded extends GoalsState {
  final List<Goal> goals;
  const GoalsLoaded(this.goals);
  @override
  List<Object?> get props => [goals];
}
class GoalsError extends GoalsState {
  final String message;
  const GoalsError(this.message);
  @override
  List<Object?> get props => [message];
} 