import 'dart:ui'; // Diperlukan untuk ImageFilter

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login_screen.dart'; // Pastikan path sesuai struktur folder Anda

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
      // 1. Ubah body menjadi Stack untuk menumpuk background blur dan konten
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
          // INI PERUBAHANNYA: Memindahkan gumpalan warna kedua ke kanan atas
          Positioned(
            top: -150, // Diubah dari bottom
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
                        label: "Kata Sandi",
                        hint: "********",
                        icon: Icons.lock_outline,
                        isPassword: true,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        label: "Email",
                        hint: "exampler@gmail.com",
                        icon: Icons.email_outlined,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        label: "Nomor Telepon",
                        hint: "+62**********",
                        icon: Icons.phone_outlined,
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(
                            0xFFF07F2F,
                          ), // Warna #F07F2F
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              30,
                            ), // Corner radius 30
                          ),
                          elevation: 4,
                          shadowColor: Colors.orange.withOpacity(0.5),
                        ),
                        child: const Text(
                          "Buat Akun",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w600, // Montserrat Semibold
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
                              fontFamily: 'Poppins',
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                            children: [
                              const TextSpan(text: "Sudah punya akun? Ayo, "),
                              TextSpan(
                                text: "Masuk!",
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen(),
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
      // DIUBAH: Mengurangi tinggi untuk menaikkan posisi teks
      height: 280,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(
          top: statusBarHeight,
          left: 24,
          right: 24,
          bottom: 24,
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Ayo Buat Akun\nBaru",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 36,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                height: 1.3,
                // DITAMBAHKAN: Mengatur jarak antar huruf
                letterSpacing: -0.41,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Yuk, isi datamu biar bisa mulai belajar\ndan bermain!",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                color: Color(0xFFA0A0A0),
                height: 1.4,
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
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            fontFamily: 'Poppins',
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey),
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
          borderRadius: BorderRadius.circular(30), // Ubah jadi 30
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(assetPath, height: 24, width: 24),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
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
