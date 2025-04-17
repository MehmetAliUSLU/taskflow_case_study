// lib/screens/create_task_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/task/task_bloc.dart';
import '../blocs/task/task_event.dart';
import '../models/task_model.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({Key? key}) : super(key: key);

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  DateTime? _dueDate;
  int _priority = 1;

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _selectDueDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
    );
    if (picked != null) setState(() => _dueDate = picked);
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate() && _dueDate != null) {
      final task = TaskModel(
        id: '',
        title: _titleController.text.trim(),
        description: _descController.text.trim(),
        dueDate: _dueDate!,
        priority: _priority,
        status: TaskStatus.pending,
        assignedTo: '',
      );
      context.read<TaskBloc>().add(AddTask(task));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (val) => val == null || val.isEmpty ? 'Enter a title' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (val) => val == null || val.isEmpty ? 'Enter a description' : null,
              ),
              const SizedBox(height: 16),
              ListTile(
                title: Text(_dueDate == null
                    ? 'Select Due Date'
                    : 'Due Date: ${_dueDate!.toLocal().toIso8601String().split('T').first}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: _selectDueDate,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<int>(
                value: _priority,
                decoration: const InputDecoration(
                  labelText: 'Priority',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 1, child: Text('Low')),
                  DropdownMenuItem(value: 2, child: Text('Medium')),
                  DropdownMenuItem(value: 3, child: Text('High')),
                ],
                onChanged: (val) => setState(() => _priority = val ?? 1),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _onSubmit,
                child: const Text('Save Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}