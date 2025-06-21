import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/schedule_item.dart';
import '../../domain/usecases/schedule_usecases.dart';
import 'package:equatable/equatable.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final GetSchedulesByDate getSchedulesByDate;
  final AddSchedule addSchedule;
  final UpdateSchedule updateSchedule;
  final DeleteSchedule deleteSchedule;

  ScheduleBloc({
    required this.getSchedulesByDate,
    required this.addSchedule,
    required this.updateSchedule,
    required this.deleteSchedule,
  }) : super(ScheduleInitial()) {
    on<LoadScheduleEvent>((event, emit) async {
      emit(ScheduleLoading());
      try {
        final schedules = await getSchedulesByDate(event.date);
        emit(ScheduleLoaded(schedules));
      } catch (e) {
        emit(ScheduleError(e.toString()));
      }
    });
    on<AddScheduleEvent>((event, emit) async {
      try {
        await addSchedule(event.schedule);
        add(LoadScheduleEvent(event.schedule.startTime));
      } catch (e) {
        emit(ScheduleError(e.toString()));
      }
    });
    on<UpdateScheduleEvent>((event, emit) async {
      try {
        await updateSchedule(event.schedule);
        add(LoadScheduleEvent(event.schedule.startTime));
      } catch (e) {
        emit(ScheduleError(e.toString()));
      }
    });
    on<DeleteScheduleEvent>((event, emit) async {
      try {
        await deleteSchedule(event.scheduleId);
        add(LoadScheduleEvent(event.date));
      } catch (e) {
        emit(ScheduleError(e.toString()));
      }
    });
  }
} 