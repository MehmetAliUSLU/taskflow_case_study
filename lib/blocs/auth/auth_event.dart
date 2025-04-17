// lib/blocs/auth/auth_event.dart

import 'package:equatable/equatable.dart';

/// Auth ile ilgili tüm event’ler burada tanımlanır.
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

/// Uygulama başladığında oturum kontrolü yapmak için tetiklenen event
class AppStarted extends AuthEvent {
  const AppStarted();
}

/// Kullanıcı giriş yaptığında tetiklenen event
class LoggedIn extends AuthEvent {
  const LoggedIn();
}

/// Kullanıcı çıkış yaptığında tetiklenen event
class LoggedOut extends AuthEvent {
  const LoggedOut();
}
