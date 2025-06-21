part of 'todos_bloc.dart';

abstract class TodosEvent extends Equatable {
  const TodosEvent();
  @override
  List<Object?> get props => [];
}

class LoadTodosEvent extends TodosEvent {
  final DateTime date;
  const LoadTodosEvent(this.date);
  @override
  List<Object?> get props => [date];
}

class AddTodoEvent extends TodosEvent {
  final Todo todo;
  const AddTodoEvent(this.todo);
  @override
  List<Object?> get props => [todo];
}

class UpdateTodoEvent extends TodosEvent {
  final Todo todo;
  const UpdateTodoEvent(this.todo);
  @override
  List<Object?> get props => [todo];
}

class DeleteTodoEvent extends TodosEvent {
  final String todoId;
  final DateTime date;
  const DeleteTodoEvent(this.todoId, this.date);
  @override
  List<Object?> get props => [todoId, date];
} 