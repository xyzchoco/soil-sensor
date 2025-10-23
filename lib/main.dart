import 'package:flutter/material.dart';
import 'package:soil/features/authentication/screens/login_screen.dart'; // Import LoginScreen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Soil Sensor UI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8F8F8),
      ),
      // Start aplikasi di halaman LoginScreen
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
