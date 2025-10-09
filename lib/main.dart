import 'package:flutter/material.dart';
import 'package:soil/navigation/main_screen.dart'; // Ganti 'soil_sensor' dengan nama project Anda

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
      // Halaman utama aplikasi sekarang adalah MainScreen
      home: const MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
