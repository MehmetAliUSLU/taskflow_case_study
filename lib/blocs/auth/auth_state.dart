// lib/blocs/auth/auth_state.dart

import 'package:equatable/equatable.dart';

/// Auth ile ilgili tüm state’ler burada tanımlanır.
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

/// Başlangıç durumu (henüz kontrol edilmedi)
class AuthInitial extends AuthState {
  const AuthInitial();
}

/// Oturum kontrol edilirken
class AuthLoading extends AuthState {
  const AuthLoading();
}

/// Kullanıcı doğrulanmışsa
class AuthAuthenticated extends AuthState {
  final String userId;

  const AuthAuthenticated(this.userId);

  @override
  List<Object> get props => [userId];
}

/// Kullanıcı oturum açmamışsa
class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

/// Hata durumları için
class AuthFailure extends AuthState {
  final String error;

  const AuthFailure(this.error);

  @override
  List<Object> get props => [error];
}
