import 'dart:ui'; // Diperlukan untuk ImageFilter

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'password_reset_success_screen.dart'; // Import harus benar

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      body: Stack(
        children: [
          // --- BACKGROUND BLUR ---
          _buildBackgroundBlur(),

          // --- KONTEN UTAMA ---
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildAppBar(context),
                  const SizedBox(height: 64),
                  _buildTitle(),
                  const SizedBox(height: 8),
                  _buildSubtitle(),
                  const SizedBox(height: 40),
                  _buildTextField(
                    label: "Kata Sandi",
                    hint: "********",
                    isPassword: true,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    label: "Konfirmasi Kata Sandi",
                    hint: "********",
                    isPassword: true,
                  ),
                  const SizedBox(height: 40),
                  _buildSubmitButton(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// WIDGET UNTUK APP BAR
  Widget _buildAppBar(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        const Expanded(
          child: Text(
            "Lupa Password",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500, // Medium
              fontSize: 20,
              letterSpacing: -0.41,
            ),
          ),
        ),
        const SizedBox(width: 48), // Spacer to balance the back button
      ],
    );
  }

  /// WIDGET UNTUK JUDUL UTAMA
  Widget _buildTitle() {
    return const Text(
      "Buat Kata Sandi Baru",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w600, // SemiBold
        fontSize: 24,
        letterSpacing: -0.41,
      ),
    );
  }

  /// WIDGET UNTUK SUB-JUDUL
  Widget _buildSubtitle() {
    return const Text(
      "Masukkan kata sandi baru Anda untuk mengamankan akun. Pastikan kata sandi kuat dan mudah diingat.",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w500, // Medium
        fontSize: 12,
        letterSpacing: -0.41,
        color: Colors.grey,
      ),
    );
  }

  /// WIDGET CUSTOM UNTUK TEXTFIELD
  Widget _buildTextField({
    required String label,
    required String hint,
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            letterSpacing: -0.41,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey),
            prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
            filled: true,
            fillColor: Colors.white.withOpacity(0.5),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15), // Corner radius 15
              borderSide: const BorderSide(
                color: Color(0xFFB3B3B3), // Warna stroke
                width: 1, // Ketebalan 1
                style: BorderStyle.solid,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15), // Corner radius 15
              borderSide: const BorderSide(
                color: Color(0xFFB3B3B3), // Warna stroke
                width: 1, // Ketebalan 1
                style: BorderStyle.solid,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15), // Corner radius 15
              borderSide: const BorderSide(
                color: Color(0xFFB3B3B3), // Warna stroke
                width: 1, // Ketebalan 1
                style: BorderStyle.solid,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// WIDGET UNTUK TOMBOL ATUR ULANG SANDI
  Widget _buildSubmitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PasswordResetSuccessScreen(), // tanpa const
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFF07F2F),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      child: const Text(
        "Atur Ulang Sandi",
        style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          fontSize: 16,
          letterSpacing: -0.41,
          color: Colors.white,
        ),
      ),
    );
  }

  /// WIDGET UNTUK BACKGROUND BLUR
  Widget _buildBackgroundBlur() {
    return Stack(
      children: [
        Positioned(
          top: -100,
          left: -150,
          child: Container(
            height: 350,
            width: 350,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFFAD0C4),
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
              color: Color(0xFFFFDAB9),
            ),
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
          child: Container(
            // ignore: deprecated_member_use
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.1)),
          ),
        ),
      ],
    );
  }
}
