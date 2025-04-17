// lib/screens/splash_screen.dart

import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Uygulama logosu veya ismi
            const FlutterLogo(size: 100),
            const SizedBox(height: 24),
            // Yükleniyor göstergesi
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
