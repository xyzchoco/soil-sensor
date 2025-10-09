import 'dart:ui'; // Diperlukan untuk ImageFilter

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'forgot_password_screen.dart'; // Tambahkan import ini
import 'register_screen.dart'; // Tambahkan import ini
import 'package:soil/features/screens/home_screen.dart'; // Pastikan import ini sesuai path HomeScreen Anda
import 'package:soil/navigation/main_screen.dart'; // Pastikan import MainScreen

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // This makes the status bar transparent and icons dark
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      body: Stack(
        children: [
          // LAPISAN 1: BENTUK-BENTUK BERWARNA YANG AKAN DIBLUR
          Positioned(
            top: -100,
            left: -150,
            child: Container(
              height: 350,
              width: 350,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFFAD0C4), // Warna pink-peach
              ),
            ),
          ),
          Positioned(
            top: -150,
            right: -150,
            child: Container(
              height: 300,
              width: 300,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFFFDAB9), // Warna peach
              ),
            ),
          ),

          // LAPISAN 2: EFEK BLUR YANG MENUTUPI SELURUH LAYAR
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
            child: Container(
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.1)),
            ),
          ),

          // LAPISAN 3: KONTEN YANG BISA DI-SCROLL
          SingleChildScrollView(
            padding: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildTextField(
                        label: "Nama Panggilan",
                        hint: "Pilih nama panggilanmu",
                        icon: Icons.person_outline,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        label: "Kata sandi",
                        hint: "********",
                        icon: Icons.lock_outline,
                        isPassword: true,
                      ),
                      const SizedBox(height: 8),
                      // Forgot Password Link
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ForgotPasswordScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "Forgot password?",
                            style: TextStyle(
                              color: Color(0xFFFF6A68),
                              fontWeight: FontWeight.w600, // semibold
                              fontFamily: 'Montserrat',
                              letterSpacing: -0.41,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) =>
                                  const MainScreen(), // atau MainScreen(initialIndex: 0)
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF07F2F),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 4,
                          shadowColor: Colors.orange.withOpacity(0.5),
                        ),
                        child: const Text(
                          "Masuk",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600, // semibold
                            fontFamily: 'Montserrat',
                            letterSpacing: -0.41,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w500, // medium
                              letterSpacing: -0.41,
                            ),
                            children: [
                              const TextSpan(text: "Belum punya akun? ayo "),
                              TextSpan(
                                text: "buat sekarang",
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500, // medium
                                  fontFamily: 'Montserrat',
                                  letterSpacing: -0.41,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterScreen(),
                                      ),
                                    );
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      _buildDivider(),
                      const SizedBox(height: 24),
                      _buildSocialButton(
                        label: "Lanjut dengan Google",
                        assetPath: "assets/images/google_logo.jpg",
                        onPressed: () {},
                      ),
                      const SizedBox(height: 16),
                      _buildSocialButton(
                        label: "Lanjut dengan Apple",
                        assetPath: "assets/images/apple_logo.png",
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// WIDGET UNTUK HEADER HALAMAN
  Widget _buildHeader(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return SizedBox(
      height: 280,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(
          top: statusBarHeight,
          left: 24,
          right: 24,
          bottom: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text(
              "Selamat Datang\nKembali!",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 32,
                fontWeight: FontWeight.w600, // semibold
                color: Colors.black,
                height: 1.3,
                letterSpacing: -0.41,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Sistem Pemantauan Tanah siap mendeteksi\nkondisi lahanmu secara real-time",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w500, // medium
                color: Color(0xFFA0A0A0),
                height: 1.4,
                letterSpacing: -0.41,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// WIDGET CUSTOM UNTUK TEXTFIELD
  Widget _buildTextField({
    required String label,
    required String hint,
    required IconData icon,
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600, // semibold
            fontSize: 15,
            color: Colors.black87,
            letterSpacing: -0.41,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          obscureText: isPassword,
          style: const TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600, // semibold
            fontSize: 15,
            letterSpacing: -0.41,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600, // semibold
              fontSize: 15,
              letterSpacing: -0.41,
            ),
            prefixIcon: Icon(icon, color: Colors.grey),
            filled: true,
            fillColor: Colors.white.withOpacity(0.5),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  /// WIDGET UNTUK DIVIDER "ATAU"
  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey.shade400)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Atau",
            style: TextStyle(
              color: Colors.grey.shade700,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        Expanded(child: Divider(color: Colors.grey.shade400)),
      ],
    );
  }

  /// WIDGET UNTUK TOMBOL LOGIN SOSIAL
  Widget _buildSocialButton({
    required String label,
    required String assetPath,
    required VoidCallback onPressed,
  }) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
        backgroundColor: Colors.white.withOpacity(0.8),
        side: BorderSide(color: Colors.grey.shade300),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // Corner radius 30
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(assetPath, height: 24, width: 24),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 22,
                color: Color(0xFFBFBFBF),
                fontWeight: FontWeight.w500, // Montserrat Medium
                fontFamily: 'Montserrat',
                letterSpacing: -0.41,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
