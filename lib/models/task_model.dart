// lib/models/task_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';

/// Görev durumlarını tanımlayan enum
enum TaskStatus { pending, inProgress, completed }

/// TaskModel: Firestore’dan gelen/verilen görev verisini temsil eder
class TaskModel {
  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  final int priority;           // 1 = düşük, 2 = orta, 3 = yüksek
  final TaskStatus status;
  final String assignedTo;      // Atanan kullanıcı ID’si

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.priority,
    required this.status,
    required this.assignedTo,
  });

  /// Firestore belgesinden TaskModel oluşturur
  factory TaskModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TaskModel(
      id: doc.id,
      title: data['title'] as String? ?? '',
      description: data['description'] as String? ?? '',
      dueDate: (data['dueDate'] as Timestamp).toDate(),
      priority: data['priority'] as int? ?? 1,
      status: TaskStatus.values.firstWhere(
            (e) => e.toString() == 'TaskStatus.${data['status']}',
        orElse: () => TaskStatus.pending,
      ),
      assignedTo: data['assignedTo'] as String? ?? '',
    );
  }

  /// TaskModel’u Firestore’a yazmak için Map’e çevirir
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'dueDate': Timestamp.fromDate(dueDate),
      'priority': priority,
      'status': status.toString().split('.').last,
      'assignedTo': assignedTo,
    };
  }
}
