// Dependency injection setup will be added here using GetIt and Injectable.

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:day_scheduler/core/db/app_database.dart';
import 'package:day_scheduler/features/goals/data/goals_local_data_source.dart';
import 'package:day_scheduler/features/goals/data/goals_repository_impl.dart';
import 'package:day_scheduler/features/todos/data/todos_local_data_source.dart';
import 'package:day_scheduler/features/todos/data/todos_repository_impl.dart';
import 'package:day_scheduler/features/schedule/data/schedule_local_data_source.dart';
import 'package:day_scheduler/features/schedule/data/schedule_repository_impl.dart';
import 'package:day_scheduler/features/goals/presentation/bloc/goals_bloc.dart';
import 'package:day_scheduler/features/todos/presentation/bloc/todos_bloc.dart';
import 'package:day_scheduler/features/schedule/presentation/bloc/schedule_bloc.dart';
import 'package:day_scheduler/features/goals/domain/usecases/goal_usecases.dart';
import 'package:day_scheduler/features/todos/domain/usecases/todo_usecases.dart';
import 'package:day_scheduler/features/schedule/domain/usecases/schedule_usecases.dart';
import 'di.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async => getIt.init();

@module
abstract class RegisterModule {
  @lazySingleton
  AppDatabase get appDatabase => AppDatabase();

  @lazySingleton
  IGoalsLocalDataSource goalsLocalDataSource(AppDatabase db) => GoalsLocalDataSource(db);
  @lazySingleton
  IGoalsRepository goalsRepository(IGoalsLocalDataSource ds) => GoalsRepositoryImpl(ds);

  @lazySingleton
  ITodosLocalDataSource todosLocalDataSource(AppDatabase db) => TodosLocalDataSource(db);
  @lazySingleton
  ITodosRepository todosRepository(ITodosLocalDataSource ds) => TodosRepositoryImpl(ds);

  @lazySingleton
  IScheduleLocalDataSource scheduleLocalDataSource(AppDatabase db) => ScheduleLocalDataSource(db);
  @lazySingleton
  IScheduleRepository scheduleRepository(IScheduleLocalDataSource ds) => ScheduleRepositoryImpl(ds);

  @lazySingleton
  GoalsBloc goalsBloc(GetGoalsByDate getGoalsByDate, AddGoal addGoal, UpdateGoal updateGoal, DeleteGoal deleteGoal) => 
    GoalsBloc(getGoalsByDate: getGoalsByDate, addGoal: addGoal, updateGoal: updateGoal, deleteGoal: deleteGoal);

  @lazySingleton
  TodosBloc todosBloc(GetTodosByDate getTodosByDate, AddTodo addTodo, UpdateTodo updateTodo, DeleteTodo deleteTodo) => 
    TodosBloc(getTodosByDate: getTodosByDate, addTodo: addTodo, updateTodo: updateTodo, deleteTodo: deleteTodo);

  @lazySingleton
  ScheduleBloc scheduleBloc(GetSchedulesByDate getSchedulesByDate, AddSchedule addSchedule, UpdateSchedule updateSchedule, DeleteSchedule deleteSchedule) => 
    ScheduleBloc(getSchedulesByDate: getSchedulesByDate, addSchedule: addSchedule, updateSchedule: updateSchedule, deleteSchedule: deleteSchedule);
} 