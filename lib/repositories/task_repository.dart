// lib/repositories/task_repository.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task_model.dart';

/// Firestore üzerinde görev CRUD operasyonlarını yöneten repository
class TaskRepository {
  final FirebaseFirestore _firestore;
  final CollectionReference _taskCollection;

  TaskRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        _taskCollection = (firestore ?? FirebaseFirestore.instance).collection('tasks');

  /// Tüm görevleri getirir
  Future<List<TaskModel>> fetchTasks() async {
    final querySnapshot = await _taskCollection.get();
    return querySnapshot.docs
        .map((doc) => TaskModel.fromDocument(doc))
        .toList();
  }

  /// Yeni bir görev oluşturur
  Future<void> createTask(TaskModel task) async {
    await _taskCollection.add(task.toMap());
  }

  /// Var olan bir görevi günceller
  Future<void> updateTask(TaskModel task) async {
    await _taskCollection.doc(task.id).update(task.toMap());
  }

  /// Bir görevi siler
  Future<void> deleteTask(String taskId) async {
    await _taskCollection.doc(taskId).delete();
  }

  /// Bir görevi bir kullanıcıya atar
  Future<void> assignTask(String taskId, String userId) async {
    await _taskCollection.doc(taskId).update({
      'assignedTo': userId,
    });
  }
}
