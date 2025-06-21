import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/todos_bloc.dart';
import 'add_todo_screen.dart';

class TodosSection extends StatelessWidget {
  final DateTime selectedDate;
  const TodosSection({super.key, required this.selectedDate});

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
                    Icon(Icons.check_box, color: Theme.of(context).primaryColor),
                    const SizedBox(width: 8),
                    const Text('Todos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AddTodoScreen(selectedDate: selectedDate),
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
            BlocBuilder<TodosBloc, TodosState>(
              builder: (context, state) {
                if (state is TodosLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is TodosLoaded) {
                  if (state.todos.isEmpty) {
                    return Container(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Icon(
                            Icons.check_box_outline_blank,
                            size: 48,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'No todos for this date',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Tap "Add" to create your first todo',
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
                    itemCount: state.todos.length,
                    itemBuilder: (context, index) {
                      final todo = state.todos[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: todo.isCompleted 
                                ? Colors.green.withOpacity(0.1)
                                : Theme.of(context).primaryColor.withOpacity(0.1),
                            child: Icon(
                              todo.isCompleted ? Icons.check : Icons.check_box_outline_blank,
                              color: todo.isCompleted ? Colors.green : Theme.of(context).primaryColor,
                              size: 20,
                            ),
                          ),
                          title: Text(
                            todo.title,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
                              color: todo.isCompleted ? Colors.grey.shade600 : null,
                            ),
                          ),
                          subtitle: todo.description != null 
                              ? Text(
                                  todo.description!,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
                                    color: todo.isCompleted ? Colors.grey.shade500 : null,
                                  ),
                                )
                              : null,
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Checkbox(
                                value: todo.isCompleted,
                                onChanged: (val) {
                                  final updatedTodo = todo.copyWith(isCompleted: val ?? false);
                                  context.read<TodosBloc>().add(UpdateTodoEvent(updatedTodo));
                                },
                              ),
                              PopupMenuButton<String>(
                                onSelected: (value) {
                                  if (value == 'delete') {
                                    context.read<TodosBloc>().add(DeleteTodoEvent(todo.id, selectedDate));
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
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is TodosError) {
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