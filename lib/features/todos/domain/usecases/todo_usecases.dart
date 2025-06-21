import '../entities/todo.dart';
import '../../data/todos_repository_impl.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetTodosByDate {
  final ITodosRepository repository;
  GetTodosByDate(this.repository);
  Future<List<Todo>> call(DateTime date) => repository.getTodosByDate(date);
}

@injectable
class AddTodo {
  final ITodosRepository repository;
  AddTodo(this.repository);
  Future<void> call(Todo todo) => repository.addTodo(todo);
}

@injectable
class UpdateTodo {
  final ITodosRepository repository;
  UpdateTodo(this.repository);
  Future<void> call(Todo todo) => repository.updateTodo(todo);
}

@injectable
class DeleteTodo {
  final ITodosRepository repository;
  DeleteTodo(this.repository);
  Future<void> call(String id) => repository.deleteTodo(id);
} 