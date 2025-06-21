import 'package:day_scheduler/core/db/app_database.dart';
import 'package:drift/drift.dart';

abstract class IGoalsLocalDataSource {
  Future<List<Goal>> getGoalsByDate(DateTime date);
  Future<void> insertGoal(GoalsCompanion goal);
  Future<void> updateGoal(GoalsCompanion goal);
  Future<void> deleteGoal(String id);
}

class GoalsLocalDataSource implements IGoalsLocalDataSource {
  final AppDatabase db;
  GoalsLocalDataSource(this.db);

  @override
  Future<List<Goal>> getGoalsByDate(DateTime date) {
    return (db.select(db.goals)..where((tbl) => tbl.date.equals(date))).get();
  }

  @override
  Future<void> insertGoal(GoalsCompanion goal) async {
    await db.into(db.goals).insertOnConflictUpdate(goal);
  }

  @override
  Future<void> updateGoal(GoalsCompanion goal) async {
    await db.update(db.goals).replace(goal);
  }

  @override
  Future<void> deleteGoal(String id) async {
    await (db.delete(db.goals)..where((tbl) => tbl.id.equals(id))).go();
  }
} 