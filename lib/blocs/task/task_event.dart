// lib/blocs/task/task_event.dart

import 'package:equatable/equatable.dart';
import '../../models/task_model.dart';

/// Task ile ilgili tüm Event’ler burada tanımlanır.
abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object?> get props => [];
}

/// Görevleri yüklemek için tetiklenen event
class LoadTasks extends TaskEvent {
  const LoadTasks();
}

/// Yeni bir görev eklemek için tetiklenen event
class AddTask extends TaskEvent {
  final TaskModel task;

  const AddTask(this.task);

  @override
  List<Object?> get props => [task];
}

/// Var olan bir görevi güncellemek için tetiklenen event
class UpdateTask extends TaskEvent {
  final TaskModel task;

  const UpdateTask(this.task);

  @override
  List<Object?> get props => [task];
}

/// Bir görevi silmek için tetiklenen event
class DeleteTask extends TaskEvent {
  final String taskId;

  const DeleteTask(this.taskId);

  @override
  List<Object?> get props => [taskId];
}

/// Bir görevi bir kullanıcıya atamak için tetiklenen event
class AssignTask extends TaskEvent {
  final String taskId;
  final String userId;

  const AssignTask({required this.taskId, required this.userId});

  @override
  List<Object?> get props => [taskId, userId];
}
