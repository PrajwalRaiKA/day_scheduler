import '../entities/goal.dart';
import '../../data/goals_repository_impl.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetGoalsByDate {
  final IGoalsRepository repository;
  GetGoalsByDate(this.repository);
  Future<List<Goal>> call(DateTime date) => repository.getGoalsByDate(date);
}

@injectable
class AddGoal {
  final IGoalsRepository repository;
  AddGoal(this.repository);
  Future<void> call(Goal goal) => repository.addGoal(goal);
}

@injectable
class UpdateGoal {
  final IGoalsRepository repository;
  UpdateGoal(this.repository);
  Future<void> call(Goal goal) => repository.updateGoal(goal);
}

@injectable
class DeleteGoal {
  final IGoalsRepository repository;
  DeleteGoal(this.repository);
  Future<void> call(String id) => repository.deleteGoal(id);
} 