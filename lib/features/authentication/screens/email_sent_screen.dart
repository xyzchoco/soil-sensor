import 'dart:ui'; // Diperlukan untuk ImageFilter
import 'otp_verification_screen.dart'; // Tambahkan import ini

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EmailSentScreen extends StatelessWidget {
  const EmailSentScreen({super.key});

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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildAppBar(context),
                  const Spacer(flex: 1),
                  _buildEmailImage(),
                  const SizedBox(height: 32),
                  _buildTitle(),
                  const SizedBox(height: 8),
                  _buildSubtitle(),
                  const Spacer(flex: 2),
                  _buildSubmitButton(context),
                  const SizedBox(height: 40),
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

  /// WIDGET UNTUK GAMBAR EMAIL
  Widget _buildEmailImage() {
    // Anda perlu menambahkan gambar email di assets/images/email_sent.png
    return Center(
      child: Image.asset(
        'assets/images/email_sent.png', // PASTIKAN NAMA DAN LOKASI FILE INI BENAR
        height: 347,
        errorBuilder: (context, error, stackTrace) {
          // Placeholder jika gambar tidak ditemukan
          return const Icon(
            Icons.mark_email_read_outlined,
            size: 150,
            color: Colors.grey,
          );
        },
      ),
    );
  }

  /// WIDGET UNTUK JUDUL UTAMA
  Widget _buildTitle() {
    return const Text(
      "Cek Email Anda",
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
      "Kami telah mengirim email untuk reset kata sandi. Silakan buka email Anda untuk melanjutkan.",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w400, // Regular
        fontSize: 12,
        letterSpacing: -0.41,
        color: Colors.grey,
      ),
    );
  }

  /// WIDGET UNTUK TOMBOL KIRIM
  Widget _buildSubmitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const OtpVerificationScreen(),
          ),
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
        "Cek Email",
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w600, // SemiBold
          fontSize: 18,
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
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.1)),
          ),
        ),
      ],
    );
  }
}
