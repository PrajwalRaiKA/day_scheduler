import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/goals_bloc.dart';
import 'add_goal_screen.dart';

class GoalsSection extends StatelessWidget {
  final DateTime selectedDate;
  const GoalsSection({super.key, required this.selectedDate});

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
                    Icon(Icons.flag, color: Theme.of(context).primaryColor),
                    const SizedBox(width: 8),
                    const Text('Goals', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AddGoalScreen(selectedDate: selectedDate),
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
            BlocBuilder<GoalsBloc, GoalsState>(
              builder: (context, state) {
                if (state is GoalsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is GoalsLoaded) {
                  if (state.goals.isEmpty) {
                    return Container(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Icon(
                            Icons.flag_outlined,
                            size: 48,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'No goals for this date',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Tap "Add" to create your first goal',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.goals.length,
                    itemBuilder: (context, index) {
                      final goal = state.goals[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                            child: Icon(
                              Icons.flag,
                              color: Theme.of(context).primaryColor,
                              size: 20,
                            ),
                          ),
                          title: Text(
                            goal.title,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          subtitle: goal.description != null 
                              ? Text(
                                  goal.description!,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                )
                              : null,
                          trailing: PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'delete') {
                                context.read<GoalsBloc>().add(DeleteGoalEvent(goal.id, selectedDate));
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
                } else if (state is GoalsError) {
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