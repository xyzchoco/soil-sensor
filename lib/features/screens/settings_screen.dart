// features/screens/settings_screen.dart

import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 20),
            _buildSettingsList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black54),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          const Expanded(
            child: Center(
              child: Text(
                'Pengaturan',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(width: 48), // Spacer
        ],
      ),
    );
  }

  Widget _buildSettingsList(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.white, // Kotak tetap putih untuk kontras
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        children: [
          _buildSettingsItem('Akun', context),
          const Divider(indent: 15, endIndent: 15, height: 1),
          _buildSettingsItem('Privasi', context),
          const Divider(indent: 15, endIndent: 15, height: 1),
          _buildSettingsItem('Notifikasi', context),
          const Divider(indent: 15, endIndent: 15, height: 1),
          _buildSettingsItem('Bahasa', context),
          const Divider(indent: 15, endIndent: 15, height: 1),
          _buildSettingsItem('Tentang', context),
          const Divider(indent: 15, endIndent: 15, height: 1),
          _buildSettingsItem('Keluar', context, isLogout: true),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(
    String title,
    BuildContext context, {
    bool isLogout = false,
  }) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: isLogout ? Colors.red : Colors.black,
          fontSize: 16,
          // PERBAIKAN: Menambahkan ketebalan pada font
          fontWeight: isLogout ? FontWeight.w500 : FontWeight.w500,
        ),
      ),
      trailing: isLogout
          ? null
          : const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: () {
        // Aksi bisa ditambahkan di sini
      },
    );
  }
}
