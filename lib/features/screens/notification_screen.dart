// features/screens/notification_screen.dart

import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildNotificationGroup('Hari ini', const [
                        {
                          'title': '30% Spesial Diskon!',
                          'subtitle':
                              'Spesial diskon untuk yang berlangganan nih!',
                        },
                      ]),
                      _buildNotificationGroup('Kemarin', const [
                        {
                          'title': 'Penilaian Kurir',
                          'subtitle':
                              'Barang sudah sampai, jangan lupa menilai kurir..',
                        },
                        {
                          'title': 'Pastikan titik koordinat dengan benar',
                          'subtitle':
                              'Tetap Kan Titik koordinat nya dengan benar yaa',
                        },
                      ]),
                      _buildNotificationGroup('June 7, 2023', const [
                        {
                          'title': 'Barang Dikirimkan Ke Alamat',
                          'subtitle':
                              'Barang Akan segera dikirimkan jangan lupa di...',
                        },
                        {
                          'title': 'Akun telah selesai disiapkan',
                          'subtitle':
                              'Akun berhasil dibuat jangan lupa melengkapi...',
                        },
                      ]),
                    ],
                  ),
                ),
              ),
            ),
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
                'Notifikasi',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(width: 48), // Spacer
        ],
      ),
    );
  }

  Widget _buildNotificationGroup(
    String title,
    List<Map<String, String>> items,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              children: items
                  .map(
                    (item) => _buildNotificationItem(
                      item['title']!,
                      item['subtitle']!,
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(String title, String subtitle) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                // PERBAIKAN: Ukuran font judul dikecilkan dari 16 menjadi 15
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                // PERBAIKAN: Ukuran font subjudul diatur menjadi 13
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
      ],
    );
  }
}
