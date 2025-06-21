import '../domain/entities/schedule_item.dart';
import 'schedule_local_data_source.dart';
import 'package:day_scheduler/core/db/app_database.dart' hide Schedule;
import 'package:drift/drift.dart';

abstract class IScheduleRepository {
  Future<List<ScheduleItem>> getSchedulesByDate(DateTime date);
  Future<void> addSchedule(ScheduleItem schedule);
  Future<void> updateSchedule(ScheduleItem schedule);
  Future<void> deleteSchedule(String id);
}

class ScheduleRepositoryImpl implements IScheduleRepository {
  final IScheduleLocalDataSource localDataSource;
  ScheduleRepositoryImpl(this.localDataSource);

  @override
  Future<List<ScheduleItem>> getSchedulesByDate(DateTime date) async {
    final dbSchedules = await localDataSource.getSchedulesByDate(date);
    return dbSchedules.map((s) => ScheduleItem(id: s.id, title: s.title, description: s.description, startTime: s.startTime, endTime: s.endTime)).toList();
  }

  @override
  Future<void> addSchedule(ScheduleItem schedule) async {
    final companion = SchedulesCompanion(
      id: Value(schedule.id),
      title: Value(schedule.title),
      description: Value(schedule.description),
      startTime: Value(schedule.startTime),
      endTime: Value(schedule.endTime),
    );
    await localDataSource.insertSchedule(companion);
  }

  @override
  Future<void> updateSchedule(ScheduleItem schedule) async {
    final companion = SchedulesCompanion(
      id: Value(schedule.id),
      title: Value(schedule.title),
      description: Value(schedule.description),
      startTime: Value(schedule.startTime),
      endTime: Value(schedule.endTime),
    );
    await localDataSource.updateSchedule(companion);
  }

  @override
  Future<void> deleteSchedule(String id) async {
    await localDataSource.deleteSchedule(id);
  }
} 