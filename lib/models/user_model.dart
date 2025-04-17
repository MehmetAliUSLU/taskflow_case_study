// lib/models/user_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';

/// Kullanıcı rollerini tanımlayan enum
enum UserRole { admin, manager, member }

/// UserModel: Firestore’dan gelen/verilen kullanıcı verisini temsil eder
class UserModel {
  final String id;
  final String name;
  final String email;
  final UserRole role;
  final String photoUrl;      // Profil resmi URL’si

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.photoUrl,
  });

  /// Firestore belgesinden UserModel oluşturur
  factory UserModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      name: data['name'] as String? ?? '',
      email: data['email'] as String? ?? '',
      role: UserRole.values.firstWhere(
            (e) => e.toString() == 'UserRole.${data['role']}',
        orElse: () => UserRole.member,
      ),
      photoUrl: data['photoUrl'] as String? ?? '',
    );
  }

  /// UserModel’u Firestore’a yazmak için Map’e çevirir
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'role': role.toString().split('.').last,
      'photoUrl': photoUrl,
    };
  }
}
