part of 'schedule_bloc.dart';

abstract class ScheduleEvent extends Equatable {
  const ScheduleEvent();
  @override
  List<Object?> get props => [];
}

class LoadScheduleEvent extends ScheduleEvent {
  final DateTime date;
  const LoadScheduleEvent(this.date);
  @override
  List<Object?> get props => [date];
}

class AddScheduleEvent extends ScheduleEvent {
  final ScheduleItem schedule;
  const AddScheduleEvent(this.schedule);
  @override
  List<Object?> get props => [schedule];
}

class UpdateScheduleEvent extends ScheduleEvent {
  final ScheduleItem schedule;
  const UpdateScheduleEvent(this.schedule);
  @override
  List<Object?> get props => [schedule];
}

class DeleteScheduleEvent extends ScheduleEvent {
  final String scheduleId;
  final DateTime date;
  const DeleteScheduleEvent(this.scheduleId, this.date);
  @override
  List<Object?> get props => [scheduleId, date];
} 