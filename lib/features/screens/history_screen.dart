// history_screen.dart

import 'package:flutter/material.dart';
import 'history_detail_screen.dart';

// Class Model untuk setiap item riwayat
class HistoryItem {
  final String id;
  final String time;
  final String date;
  final String location;
  final double temperature;
  final double humidity;
  final double ph;
  final double conductivity;
  final int nitrogen;
  final int phosphor;
  final int kalium;
  final String fertility;

  const HistoryItem({
    required this.id,
    required this.time,
    required this.date,
    required this.location,
    required this.temperature,
    required this.humidity,
    required this.ph,
    required this.conductivity,
    required this.nitrogen,
    required this.phosphor,
    required this.kalium,
    required this.fertility,
  });
}

class HistoryScreen extends StatelessWidget {
  final List<HistoryItem> historyData;
  final Function(String itemId) onDelete; // Callback untuk menghapus item

  const HistoryScreen({
    super.key,
    required this.historyData,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final groupedData = _groupHistoryByDate(historyData);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const Center(
                  child: Text(
                    'History',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Catat perkembangannya secara rutin dan lihat riwayat lengkapnya di halaman ini.',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                const SizedBox(height: 30),
                if (historyData.isEmpty)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 50.0),
                      child: Text('Belum ada data riwayat yang disimpan.'),
                    ),
                  )
                else
                  // Membangun daftar item riwayat yang sudah dikelompokkan
                  ..._buildGroupedList(context, groupedData),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Mengelompokkan riwayat berdasarkan tanggal (Hari ini, Kemarin, atau tanggal lain).
  Map<String, List<HistoryItem>> _groupHistoryByDate(
    List<HistoryItem> history,
  ) {
    Map<String, List<HistoryItem>> groupedData = {};
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));

    final todayString = _formatDateForComparison(now);
    final yesterdayString = _formatDateForComparison(yesterday);

    for (var item in history) {
      // Ekstrak hanya tanggal dari string lengkap
      final itemDateString = item.date
          .substring(item.date.indexOf(',') + 2)
          .trim();
      String key;

      if (itemDateString == todayString) {
        key = 'Hari ini';
      } else if (itemDateString == yesterdayString) {
        key = 'Kemarin';
      } else {
        key = itemDateString;
      }

      if (!groupedData.containsKey(key)) {
        groupedData[key] = [];
      }
      groupedData[key]!.add(item);
    }
    return groupedData;
  }

  /// Format tanggal untuk perbandingan yang konsisten.
  String _formatDateForComparison(DateTime date) {
    const months = [
      '',
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    return '${date.day} ${months[date.month]} ${date.year}';
  }

  /// Membangun daftar widget dari data yang sudah dikelompokkan.
  List<Widget> _buildGroupedList(
    BuildContext context,
    Map<String, List<HistoryItem>> groupedData,
  ) {
    List<Widget> widgets = [];
    groupedData.forEach((groupTitle, items) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.only(top: 20.0, bottom: 5.0),
          child: Text(
            groupTitle,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      );

      for (var item in items) {
        widgets.add(_buildHistoryTile(context, item));
        widgets.add(const Divider(height: 1, color: Color(0xFFEEEEEE)));
      }
    });
    return widgets;
  }

  /// Widget untuk satu baris item riwayat.
  Widget _buildHistoryTile(BuildContext context, HistoryItem item) {
    return InkWell(
      onTap: () {
        // Navigasi ke layar detail saat item diklik.
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => HistoryDetailScreen(
              item: item,
              // === PERBAIKAN UTAMA ===
              // Meneruskan fungsi `onDelete` secara langsung.
              // HistoryDetailScreen akan memanggilnya dengan ID yang sesuai.
              onDelete: onDelete,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.time,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.date,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),
              ],
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
