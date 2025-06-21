part of 'todos_bloc.dart';

abstract class TodosState extends Equatable {
  const TodosState();
  @override
  List<Object?> get props => [];
}

class TodosInitial extends TodosState {}
class TodosLoading extends TodosState {}
class TodosLoaded extends TodosState {
  final List<Todo> todos;
  const TodosLoaded(this.todos);
  @override
  List<Object?> get props => [todos];
}
class TodosError extends TodosState {
  final String message;
  const TodosError(this.message);
  @override
  List<Object?> get props => [message];
} 