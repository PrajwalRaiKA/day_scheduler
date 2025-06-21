import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/schedule_bloc.dart';
import 'add_schedule_screen.dart';

class ScheduleSection extends StatelessWidget {
  final DateTime selectedDate;
  const ScheduleSection({super.key, required this.selectedDate});

  String _formatTime(DateTime time) {
    final hour = time.hour;
    final minute = time.minute;
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
    return '${displayHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.schedule, color: Theme.of(context).primaryColor),
                    const SizedBox(width: 8),
                    const Text('Schedule', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AddScheduleScreen(selectedDate: selectedDate),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Add'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            BlocBuilder<ScheduleBloc, ScheduleState>(
              builder: (context, state) {
                if (state is ScheduleLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ScheduleLoaded) {
                  if (state.schedules.isEmpty) {
                    return Container(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Icon(
                            Icons.schedule_outlined,
                            size: 48,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'No schedules for this date',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Tap "Add" to create your first schedule',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  
                  // Sort schedules by start time
                  final sortedSchedules = List.from(state.schedules)
                    ..sort((a, b) => a.startTime.compareTo(b.startTime));
                  
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: sortedSchedules.length,
                    itemBuilder: (context, index) {
                      final schedule = sortedSchedules[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                            child: Icon(
                              Icons.schedule,
                              color: Theme.of(context).primaryColor,
                              size: 20,
                            ),
                          ),
                          title: Text(
                            schedule.title,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${_formatTime(schedule.startTime)} - ${_formatTime(schedule.endTime)}',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              if (schedule.description != null) ...[
                                const SizedBox(height: 4),
                                Text(
                                  schedule.description!,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ],
                          ),
                          trailing: PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'delete') {
                                context.read<ScheduleBloc>().add(DeleteScheduleEvent(schedule.id, selectedDate));
                              }
                            },
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 'delete',
                                child: Row(
                                  children: [
                                    Icon(Icons.delete, color: Colors.red),
                                    SizedBox(width: 8),
                                    Text('Delete'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is ScheduleError) {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(Icons.error, color: Colors.red.shade400),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Error: ${state.message}',
                            style: TextStyle(color: Colors.red.shade600),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
} 