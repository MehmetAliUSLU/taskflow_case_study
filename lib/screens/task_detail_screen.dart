// lib/screens/task_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/task_model.dart';
import '../blocs/task/task_bloc.dart';
import '../blocs/task/task_event.dart';

class TaskDetailScreen extends StatefulWidget {
  final TaskModel task;

  const TaskDetailScreen({Key? key, required this.task}) : super(key: key);

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  late TaskStatus _status;
  late int _priority;

  @override
  void initState() {
    super.initState();
    _status = widget.task.status;
    _priority = widget.task.priority;
  }

  void _onSave() {
    final updatedTask = TaskModel(
      id: widget.task.id,
      title: widget.task.title,
      description: widget.task.description,
      dueDate: widget.task.dueDate,
      priority: _priority,
      status: _status,
      assignedTo: widget.task.assignedTo,
    );
    context.read<TaskBloc>().add(UpdateTask(updatedTask));
    Navigator.of(context).pop();
  }

  void _onDelete() {
    context.read<TaskBloc>().add(DeleteTask(widget.task.id));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _onDelete,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.task.description),
            const SizedBox(height: 16),
            Text('Due date: ${widget.task.dueDate.toLocal().toIso8601String().split('T').first}'),
            const SizedBox(height: 16),
            const Text('Status'),
            DropdownButton<TaskStatus>(
              value: _status,
              items: TaskStatus.values
                  .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e.toString().split('.').last),
              ))
                  .toList(),
              onChanged: (val) {
                if (val != null) setState(() => _status = val);
              },
            ),
            const SizedBox(height: 16),
            const Text('Priority'),
            DropdownButton<int>(
              value: _priority,
              items: const [
                DropdownMenuItem(value: 1, child: Text('Low')),
                DropdownMenuItem(value: 2, child: Text('Medium')),
                DropdownMenuItem(value: 3, child: Text('High')),
              ],
              onChanged: (val) {
                if (val != null) setState(() => _priority = val);
              },
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: _onSave,
                child: const Text('Save Changes'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
