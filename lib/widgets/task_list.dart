// lib/widgets/task_list.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/task/task_bloc.dart';
import '../blocs/task/task_event.dart';
import '../blocs/task/task_state.dart';
import '../models/task_model.dart';
import 'task_item.dart';
import '../screens/task_detail_screen.dart';

/// Görev listesini Bloc üzerinden dinleyerek oluşturan widget
class TaskList extends StatelessWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state is TaskLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is TaskLoaded) {
          final List<TaskModel> tasks = state.tasks;
          if (tasks.isEmpty) {
            return const Center(child: Text('No tasks found.'));
          }
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return TaskItem(
                task: task,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => TaskDetailScreen(task: task),
                    ),
                  );
                },
                onDelete: () {
                  context.read<TaskBloc>().add(DeleteTask(task.id));
                },
                onAssign: () {
                  // Atama işlemi için örnek dialog açabilirsiniz
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Assign Task'),
                      content: const Text('Implement user selection here…'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            // Örnek userId ile atama
                            context.read<TaskBloc>().add(
                              AssignTask(
                                taskId: task.id,
                                userId: 'someUserId',
                              ),
                            );
                            Navigator.pop(context);
                          },
                          child: const Text('Assign'),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        }
        if (state is TaskError) {
          return Center(child: Text('Error: ${state.error}'));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
