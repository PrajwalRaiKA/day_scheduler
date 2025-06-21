part of 'schedule_bloc.dart';

abstract class ScheduleState extends Equatable {
  const ScheduleState();
  @override
  List<Object?> get props => [];
}

class ScheduleInitial extends ScheduleState {}
class ScheduleLoading extends ScheduleState {}
class ScheduleLoaded extends ScheduleState {
  final List<ScheduleItem> schedules;
  const ScheduleLoaded(this.schedules);
  @override
  List<Object?> get props => [schedules];
}
class ScheduleError extends ScheduleState {
  final String message;
  const ScheduleError(this.message);
  @override
  List<Object?> get props => [message];
} 