import '../entities/schedule_item.dart';
import '../../data/schedule_repository_impl.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetSchedulesByDate {
  final IScheduleRepository repository;
  GetSchedulesByDate(this.repository);
  Future<List<ScheduleItem>> call(DateTime date) => repository.getSchedulesByDate(date);
}

@injectable
class AddSchedule {
  final IScheduleRepository repository;
  AddSchedule(this.repository);
  Future<void> call(ScheduleItem schedule) => repository.addSchedule(schedule);
}

@injectable
class UpdateSchedule {
  final IScheduleRepository repository;
  UpdateSchedule(this.repository);
  Future<void> call(ScheduleItem schedule) => repository.updateSchedule(schedule);
}

@injectable
class DeleteSchedule {
  final IScheduleRepository repository;
  DeleteSchedule(this.repository);
  Future<void> call(String id) => repository.deleteSchedule(id);
} 