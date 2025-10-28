// features/screens/profile_screen.dart

import 'package:flutter/material.dart';
// import 'settings_screen.dart'; // <-- Dihapus, karena tombol Pengaturan tidak ada

class ProfileScreen extends StatelessWidget {
  final VoidCallback onBack;
  final ScrollController scrollController;

  // --- PERBAIKAN 1: Constructor dibenerin ---
  const ProfileScreen({
    super.key,
    required this.onBack,
    required this.scrollController, // <-- Harusnya di dalam sini
  });
  // -----------------------------------------

  // Fungsi untuk menampilkan dialog konfirmasi (Tidak ada perubahan)
  void _showConfirmationDialog(
    BuildContext context, {
    required String title,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor:
              Colors.white, // PERBAIKAN: Mengubah warna background dialog
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actionsPadding: const EdgeInsets.only(
            bottom: 20,
            left: 20,
            right: 20,
          ),
          actions: <Widget>[
            // Tombol Tidak
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade200,
                  foregroundColor: Colors.black54,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: Text('Tidak'),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            const SizedBox(width: 10),
            // Tombol Ya
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: Text('Ya'),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  onConfirm(); // Jalankan aksi setelah konfirmasi
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // --- PERUBAHAN: Scaffold dihapus ---
    // Widget ini sekarang siap dimasukkan ke dalam Scaffold di main_screen.dart
    return SafeArea(
      child: SingleChildScrollView(
        // --- PERBAIKAN 2: Controller dipasang di sini ---
        controller: scrollController,
        // ------------------------------------------
        child: Column(
          children: [
            _buildHeader(context),
            _buildProfileCard(),
            _buildPersonalInfoSection(), // <-- Ada perubahan di dalam sini
            _buildActionButtons(context), // <-- Ada perubahan di dalam sini
          ],
        ),
      ),
    );
  }

  // Header tetap sama sesuai gambar
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  // ignore: deprecated_member_use
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black54),
              onPressed: onBack,
            ),
          ),
          const Text(
            'Profile',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 48), // Spacer
        ],
      ),
    );
  }

  // Profile card tetap sama sesuai gambar
  Widget _buildProfileCard() {
    return Container(
      margin: const EdgeInsets.only(top: 70, left: 20, right: 20, bottom: 20),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: const LinearGradient(
                colors: [Color(0xFFF5A04D), Color(0xFFE8752B)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Username10282628',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Manajemen Sistem | Administrator',
                        style: TextStyle(
                          // ignore: deprecated_member_use
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: -50,
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 46,
                    backgroundImage: const AssetImage(
                      'assets/images/yengskut.png',
                    ),
                    onBackgroundImageError: (_, __) {},
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          // ignore: deprecated_member_use
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(1, 1),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(4),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.grey,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- PERUBAHAN: Disesuaikan dengan gambar ---
  Widget _buildPersonalInfoSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Data Pribadi', // <-- Diubah
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF07F2F),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Edit'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: const Color(0xFFF6F8FA),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              // ignore: deprecated_member_use
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
            ],
          ),
          child: Column(
            children: [
              _buildTextField(
                label: 'Nama Pengguna', // <-- Diubah
                hint: 'Nama Lengkap',
                icon: Icons.person_outline,
              ),
              _buildTextField(
                label: 'Kata Sandi',
                hint: '••••••••••',
                icon: Icons.lock_outline,
                obscureText: true,
              ),
              _buildTextField(
                label: 'Email',
                hint: 'example@gmail.com',
                icon: Icons.email_outlined,
              ),
              // <-- Field lainnya dihapus agar sesuai gambar
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required IconData icon,
    bool obscureText = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5),
          TextField(
            obscureText: obscureText,
            decoration: InputDecoration(
              hintText: hint,
              prefixIcon: Icon(icon, color: Colors.grey),
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- PERUBAHAN: Disesuaikan dengan gambar ---
  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          // --- Tombol Pengaturan dihapus ---
          _buildActionButton(
            text: 'Ganti Akun',
            color: const Color(0xFFF07F2F),
            icon: Icons.refresh, // <-- Ikon ditambahkan
            onPressed: () {
              _showConfirmationDialog(
                context,
                title: 'Apakah Anda yakin ingin ganti akun?',
                onConfirm: () {
                  // Tambahkan logika untuk ganti akun di sini
                },
              );
            },
          ),
          const SizedBox(height: 15),
          _buildActionButton(
            text: 'Keluar',
            color: Colors.red,
            icon: Icons.power_settings_new, // <-- Ikon ditambahkan
            onPressed: () {
              _showConfirmationDialog(
                context,
                title: 'Apakah Anda yakin ingin keluar dari aplikasi?',
                onConfirm: () {
                  // Tambahkan logika untuk keluar dari aplikasi di sini
                },
              );
            },
          ),
        ],
      ),
    );
  }

  // --- Widget _buildOptionTile dihapus karena tidak dipakai ---

  // --- PERUBAHAN: Ditambahkan parameter icon & Row ---
  Widget _buildActionButton({
    required String text,
    required Color color,
    required IconData icon, // <-- Parameter ikon ditambahkan
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Colors.white,
          foregroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            // ignore: deprecated_member_use
            side: BorderSide(color: color.withOpacity(0.5)),
          ),
          elevation: 0,
        ),
        // --- Child diubah menjadi Row ---
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 10),
            Text(text),
          ],
        ),
      ),
    );
  }
}
