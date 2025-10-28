import 'dart:ui'; // Diperlukan untuk ImageFilter

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'email_sent_screen.dart'; // Tambahkan import ini

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

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
                  const SizedBox(height: 32),
                  _buildPadlockImage(),
                  const SizedBox(height: 32),
                  _buildTitle(),
                  const SizedBox(height: 8),
                  _buildSubtitle(),
                  const SizedBox(height: 40),
                  _buildEmailTextField(),
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

  /// WIDGET UNTUK GAMBAR GEMBOK
  Widget _buildPadlockImage() {
    // Anda perlu menambahkan gambar gembok di assets/images/padlock.png
    return Center(
      child: Image.asset(
        'assets/images/padlock.png', // GANTI DENGAN PATH GAMBAR ANDA
        height: 150,
        errorBuilder: (context, error, stackTrace) {
          // Placeholder jika gambar tidak ditemukan
          return const Icon(Icons.lock_outline, size: 150, color: Colors.grey);
        },
      ),
    );
  }

  /// WIDGET UNTUK JUDUL UTAMA
  Widget _buildTitle() {
    return const Text(
      "Masukkan email Anda",
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
      "Masukkan alamat email anda untuk mendapatkan kode 6 digit untuk melanjutkan pengiriman.",
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

  /// WIDGET UNTUK INPUT EMAIL
  Widget _buildEmailTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Email",
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600, // SemiBold
            fontSize: 15,
            letterSpacing: -0.41,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: "Masukkan Email",
            hintStyle: const TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w500, // Medium
              fontSize: 15,
              letterSpacing: -0.41,
              color: Colors.grey,
            ),
            prefixIcon: const Icon(Icons.email_outlined, color: Colors.grey),
            filled: true,
            fillColor: Colors.white.withAlpha(128),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(90), // Corner radius 90
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  /// WIDGET UNTUK TOMBOL KIRIM
  Widget _buildSubmitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const EmailSentScreen()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFF07F2F),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // Corner radius 30
        ),
      ),
      child: const Text(
        "Kirim",
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w500, // Medium
          fontSize: 15,
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
            decoration: BoxDecoration(color: Colors.white.withAlpha(26)),
          ),
        ),
      ],
    );
  }
}
