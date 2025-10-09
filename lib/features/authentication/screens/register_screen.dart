import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                // ... (Sisa kodenya sama persis)
                // ... Anda bisa langsung mengganti widget _buildHeader
                // ... dengan versi di bawah ini
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk Header DENGAN FONT BARU
  Widget _buildHeader() {
    return Container(
      height: 250,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/register_background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.3), Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          const Positioned(
            bottom: 24,
            left: 24,
            right: 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ayo Buat Akun Baru",
                  style: TextStyle(
                    fontFamily: 'Montserrat', // <-- FONT MONTSERRAT UNTUK JUDUL
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Yuk, isi datamu biar bisa mulai belajar dan bermain!",
                  style: TextStyle(
                    fontFamily: 'Poppins', // <-- FONT POPPINS UNTUK SUB-JUDUL
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ... (Sisa widget _buildTextField, _buildDivider, dll tetap sama)
}
