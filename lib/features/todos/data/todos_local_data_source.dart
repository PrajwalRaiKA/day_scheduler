import 'package:day_scheduler/core/db/app_database.dart';
import 'package:drift/drift.dart';

abstract class ITodosLocalDataSource {
  Future<List<Todo>> getTodosByDate(DateTime date);
  Future<void> insertTodo(TodosCompanion todo);
  Future<void> updateTodo(TodosCompanion todo);
  Future<void> deleteTodo(String id);
}

class TodosLocalDataSource implements ITodosLocalDataSource {
  final AppDatabase db;
  TodosLocalDataSource(this.db);

  @override
  Future<List<Todo>> getTodosByDate(DateTime date) {
    return (db.select(db.todos)..where((tbl) => tbl.date.equals(date))).get();
  }

  @override
  Future<void> insertTodo(TodosCompanion todo) async {
    await db.into(db.todos).insertOnConflictUpdate(todo);
  }

  @override
  Future<void> updateTodo(TodosCompanion todo) async {
    await db.update(db.todos).replace(todo);
  }

  @override
  Future<void> deleteTodo(String id) async {
    await (db.delete(db.todos)..where((tbl) => tbl.id.equals(id))).go();
  }
} 