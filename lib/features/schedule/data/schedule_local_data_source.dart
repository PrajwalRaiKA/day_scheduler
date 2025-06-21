import 'package:day_scheduler/core/db/app_database.dart';
import 'package:drift/drift.dart';

abstract class IScheduleLocalDataSource {
  Future<List<Schedule>> getSchedulesByDate(DateTime date);
  Future<void> insertSchedule(SchedulesCompanion schedule);
  Future<void> updateSchedule(SchedulesCompanion schedule);
  Future<void> deleteSchedule(String id);
}

class ScheduleLocalDataSource implements IScheduleLocalDataSource {
  final AppDatabase db;
  ScheduleLocalDataSource(this.db);

  @override
  Future<List<Schedule>> getSchedulesByDate(DateTime date) {
    // Fetch schedules where startTime or endTime falls on the given date
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(Duration(days: 1));
    return (db.select(db.schedules)
      ..where((tbl) => tbl.startTime.isBiggerOrEqualValue(start) & tbl.startTime.isSmallerThanValue(end)))
      .get();
  }

  @override
  Future<void> insertSchedule(SchedulesCompanion schedule) async {
    await db.into(db.schedules).insertOnConflictUpdate(schedule);
  }

  @override
  Future<void> updateSchedule(SchedulesCompanion schedule) async {
    await db.update(db.schedules).replace(schedule);
  }

  @override
  Future<void> deleteSchedule(String id) async {
    await (db.delete(db.schedules)..where((tbl) => tbl.id.equals(id))).go();
  }
} 