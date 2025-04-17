// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/task/task_bloc.dart';
import '../blocs/task/task_event.dart';
import '../blocs/task/task_state.dart';
import '../repositories/task_repository.dart';
import 'create_task_screen.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_event.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TaskBloc>(
      create: (_) => TaskBloc(taskRepository: TaskRepository())..add(const LoadTasks()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tasks'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                context.read<AuthBloc>().add(const LoggedOut());
              },
            ),
          ],
        ),
        body: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state is TaskLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TaskLoaded) {
              final tasks = state.tasks;
              if (tasks.isEmpty) {
                return const Center(child: Text('No tasks found.'));
              }
              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return ListTile(
                    title: Text(task.title),
                    subtitle: Text(task.description),
                    trailing: Text(task.status.toString().split('.').last),
                    onTap: () {
                      // TODO: Navigate to task detail
                    },
                  );
                },
              );
            } else if (state is TaskError) {
              return Center(child: Text('Error: ${state.error}'));
            }
            return const SizedBox();
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const CreateTaskScreen()),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
