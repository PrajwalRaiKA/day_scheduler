import '../domain/entities/todo.dart';
import 'todos_local_data_source.dart';
import 'package:day_scheduler/core/db/app_database.dart' hide Todo;
import 'package:drift/drift.dart';

abstract class ITodosRepository {
  Future<List<Todo>> getTodosByDate(DateTime date);
  Future<void> addTodo(Todo todo);
  Future<void> updateTodo(Todo todo);
  Future<void> deleteTodo(String id);
}

class TodosRepositoryImpl implements ITodosRepository {
  final ITodosLocalDataSource localDataSource;
  TodosRepositoryImpl(this.localDataSource);

  @override
  Future<List<Todo>> getTodosByDate(DateTime date) async {
    final dbTodos = await localDataSource.getTodosByDate(date);
    return dbTodos.map((t) => Todo(id: t.id, title: t.title, description: t.description, isCompleted: t.isCompleted, date: t.date)).toList();
  }

  @override
  Future<void> addTodo(Todo todo) async {
    final companion = TodosCompanion(
      id: Value(todo.id),
      title: Value(todo.title),
      description: Value(todo.description),
      isCompleted: Value(todo.isCompleted),
      date: Value(todo.date),
    );
    await localDataSource.insertTodo(companion);
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    final companion = TodosCompanion(
      id: Value(todo.id),
      title: Value(todo.title),
      description: Value(todo.description),
      isCompleted: Value(todo.isCompleted),
      date: Value(todo.date),
    );
    await localDataSource.updateTodo(companion);
  }

  @override
  Future<void> deleteTodo(String id) async {
    await localDataSource.deleteTodo(id);
  }
} 