import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'reset_password_screen.dart'; // Tambahkan import ini

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({super.key});

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
          _buildBackgroundBlur(),
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
                  _OtpForm(),
                  const SizedBox(height: 40),
                  _buildSubmitButton(context),
                  const SizedBox(height: 24),
                  _buildResendCodeLink(),
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
        const SizedBox(width: 48),
      ],
    );
  }

  /// WIDGET UNTUK JUDUL UTAMA
  Widget _buildTitle() {
    return const Text(
      "Selesaikan verifikasi email Anda",
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
      "Gunakan kode 6 digit yang baru saja kami kirim untuk melanjutkan pengiriman.",
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

  /// WIDGET UNTUK TOMBOL SELANJUTNYA
  Widget _buildSubmitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const ResetPasswordScreen()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFF07F2F),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      child: const Text(
        "Selanjutnya",
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

  /// WIDGET UNTUK LINK KIRIM ULANG KODE
  Widget _buildResendCodeLink() {
    return Center(
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontFamily: 'Poppins',
            color: Colors.grey,
            fontSize: 14,
            letterSpacing: -0.41,
          ),
          children: [
            const TextSpan(text: "Blum menerima kode? "),
            TextSpan(
              text: "Kirim Ulang",
              style: const TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  // TODO: Tambahkan logika untuk kirim ulang kode
                  print("Kirim ulang kode");
                },
            ),
          ],
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

/// FORM OTP DENGAN 6 DIGIT
class _OtpForm extends StatefulWidget {
  @override
  State<_OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<_OtpForm> {
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  final List<TextEditingController> _controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );

  @override
  void dispose() {
    for (final node in _focusNodes) {
      node.dispose();
    }
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        4,
        (index) => SizedBox(
          width: 65,
          height: 58,
          child: TextField(
            controller: _controllers[index],
            focusNode: _focusNodes[index],
            onChanged: (value) {
              if (value.length == 1 && index < 3) {
                _focusNodes[index + 1].requestFocus();
              } else if (value.isEmpty && index > 0) {
                _focusNodes[index - 1].requestFocus();
              }
            },
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly,
            ],
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              filled: true,
              // ignore: deprecated_member_use
              fillColor: Colors.white.withOpacity(0.5),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFF898A8D), // Warna stroke
                  width: 1, // Ketebalan 1
                  style: BorderStyle.solid,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFF898A8D), // Warna stroke
                  width: 1, // Ketebalan 1
                  style: BorderStyle.solid,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFF898A8D), // Warna stroke
                  width: 1, // Ketebalan 1
                  style: BorderStyle.solid,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
