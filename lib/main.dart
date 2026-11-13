import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'login_screen.dart';

void main() {
  runApp(const StudentApp());
}

class StudentApp extends StatelessWidget {
  const StudentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Navigation App',
      theme: AppTheme.theme,
      home: const LoginScreen(),
    );
  }
}
