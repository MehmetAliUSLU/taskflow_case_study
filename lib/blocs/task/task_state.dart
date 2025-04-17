// lib/blocs/task/task_state.dart

import 'package:equatable/equatable.dart';
import '../../models/task_model.dart';

/// Task ile ilgili tüm State’ler burada tanımlanır.
abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object?> get props => [];
}

/// Görevler yüklenirken
class TaskLoading extends TaskState {
  const TaskLoading();
}

/// Görevler başarıyla yüklendiğinde
class TaskLoaded extends TaskState {
  final List<TaskModel> tasks;

  const TaskLoaded(this.tasks);

  @override
  List<Object?> get props => [tasks];
}

/// İşlem sırasında bir hata oluştuğunda
class TaskError extends TaskState {
  final String error;

  const TaskError(this.error);

  @override
  List<Object?> get props => [error];
}
