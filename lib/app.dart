// lib/app.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'repositories/auth_repository.dart';
import 'blocs/auth/auth_bloc.dart';
import 'blocs/auth/auth_event.dart';
import 'blocs/auth/auth_state.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';

class App extends StatelessWidget {
  final AuthRepository _authRepository = AuthRepository();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AuthRepository>(
      create: (_) => _authRepository,
      child: BlocProvider<AuthBloc>(
        create: (_) => AuthBloc(authRepository: _authRepository)
          ..add(AppStarted()),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return MaterialApp(
              title: 'taskflow_case_study',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.deepPurple,
                ),
              ),
              routes: {
                '/login': (_) => const LoginScreen(),
                '/register': (_) => const RegisterScreen(),
                '/home': (_) => const HomeScreen(),
              },
              home: _selectHome(state),
            );
          },
        ),
      ),
    );
  }

  Widget _selectHome(AuthState state) {
    if (state is AuthInitial || state is AuthLoading) {
      return const SplashScreen();
    } else if (state is AuthAuthenticated) {
      return const HomeScreen();
    } else {
      return const LoginScreen();
    }
  }
}
