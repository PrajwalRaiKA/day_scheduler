import '../domain/entities/goal.dart';
import 'goals_local_data_source.dart';
import 'package:day_scheduler/core/db/app_database.dart' hide Goal;
import 'package:drift/drift.dart';

abstract class IGoalsRepository {
  Future<List<Goal>> getGoalsByDate(DateTime date);
  Future<void> addGoal(Goal goal);
  Future<void> updateGoal(Goal goal);
  Future<void> deleteGoal(String id);
}

class GoalsRepositoryImpl implements IGoalsRepository {
  final IGoalsLocalDataSource localDataSource;
  GoalsRepositoryImpl(this.localDataSource);

  @override
  Future<List<Goal>> getGoalsByDate(DateTime date) async {
    final dbGoals = await localDataSource.getGoalsByDate(date);
    return dbGoals.map((g) => Goal(id: g.id, title: g.title, description: g.description, date: g.date)).toList();
  }

  @override
  Future<void> addGoal(Goal goal) async {
    final companion = GoalsCompanion(
      id: Value(goal.id),
      title: Value(goal.title),
      description: Value(goal.description),
      date: Value(goal.date),
    );
    await localDataSource.insertGoal(companion);
  }

  @override
  Future<void> updateGoal(Goal goal) async {
    final companion = GoalsCompanion(
      id: Value(goal.id),
      title: Value(goal.title),
      description: Value(goal.description),
      date: Value(goal.date),
    );
    await localDataSource.updateGoal(companion);
  }

  @override
  Future<void> deleteGoal(String id) async {
    await localDataSource.deleteGoal(id);
  }
} 