// lib/widgets/task_item.dart

import 'package:flutter/material.dart';
import '../models/task_model.dart';

/// Tek bir görevi liste içinde göstermek için kullanılan widget
class TaskItem extends StatelessWidget {
  final TaskModel task;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final VoidCallback? onAssign;

  const TaskItem({
    Key? key,
    required this.task,
    this.onTap,
    this.onDelete,
    this.onAssign,
  }) : super(key: key);

  Color _statusColor(TaskStatus status) {
    switch (status) {
      case TaskStatus.pending:
        return Colors.orange;
      case TaskStatus.inProgress:
        return Colors.blue;
      case TaskStatus.completed:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: _statusColor(task.status),
          child: Text(
            task.priority.toString(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(task.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(task.description, maxLines: 1, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 4),
            Text(
              'Due: ${task.dueDate.toLocal().toIso8601String().split('T').first}',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (onAssign != null)
              IconButton(
                icon: const Icon(Icons.person_add),
                tooltip: 'Assign',
                onPressed: onAssign,
              ),
            if (onDelete != null)
              IconButton(
                icon: const Icon(Icons.delete),
                tooltip: 'Delete',
                onPressed: onDelete,
              ),
          ],
        ),
      ),
    );
  }
}
