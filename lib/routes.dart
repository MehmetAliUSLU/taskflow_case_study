
// lib/routes.dart

import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';

/// Uygulamadaki tüm rota adlarını merkezi olarak burada tanımlıyoruz.
class RoutePaths {
  static const String splash    = '/';
  static const String login     = '/login';
  static const String register  = '/register';
  static const String home      = '/home';
}

/// Route üreticisi: gelen rota adına göre ilgili ekranı döndürür.
class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RoutePaths.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case RoutePaths.register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case RoutePaths.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
