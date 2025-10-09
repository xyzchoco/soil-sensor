// lib/main.dart
import 'package:flutter/material.dart';
import 'package:soil/features/authentication/screens/register_screen.dart'; // Sesuaikan import

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi IoT Kontainer',
      theme: ThemeData(
        // Atur Poppins sebagai font default untuk seluruh aplikasi
        fontFamily: 'Poppins',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const RegisterScreen(),
    );
  }
}
