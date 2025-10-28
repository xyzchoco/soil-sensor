// main_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

// Pastikan path ini sesuai dengan struktur folder proyek Anda
import 'package:soil/features/screens/home_screen.dart';
import 'package:soil/features/screens/history_screen.dart'; // HistoryItem harusnya HANYA dari sini
import 'package:soil/features/screens/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  late final ScrollController _scrollController;
  bool _isNavBarVisible = true;

  // Data Statistik & Lokasi default
  static const String defaultLocation = 'Politeknik Negeri Lampung';
  static const double defaultTemperature = 24.0;
  static const double defaultHumidity = 4.0;
  static const double defaultPh = 7.0;
  static const double defaultConductivity = 8.5;
  static const int defaultN = 12;
  static const int defaultP = 52;
  static const int defaultK = 22;
  static const String defaultFertility = '170 mg/kg';
  static const double defaultKwh = 45.0; // Nilai dummy KWH dari home_screen

  final List<HistoryItem> _historyData = [];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);

    // --- Format tanggal hari ini ---
    final now = DateTime.now();
    final todayDateString =
        "${_getDayName(now.weekday)}, ${now.day} ${_getMonthName(now.month)} ${now.year}";

    _historyData.addAll(
      [
        // ... (Data history Abang tetap sama, tidak saya ubah) ...
        HistoryItem(
          id: 'h${DateTime.now().microsecondsSinceEpoch + 100}',
          time: "15:00",
          date: "${_getDayName(2)}, 20 Oktober 2025", // Selasa
          location: defaultLocation,
          temperature: 26.0,
          humidity: 6.2,
          ph: 6.8,
          conductivity: 7.9,
          nitrogen: 12,
          phosphor: 52,
          kalium: 22,
          fertility: defaultFertility,
          kwhValue: defaultKwh,
        ),
        HistoryItem(
          id: 'k${DateTime.now().microsecondsSinceEpoch + 200}',
          time: "20:00",
          date: "${_getDayName(1)}, 19 Oktober 2025", // Senin
          location: 'Kebun Percobaan Natar',
          temperature: 25.5,
          humidity: 4.0,
          ph: 7.0,
          conductivity: 8.5,
          nitrogen: 15,
          phosphor: 40,
          kalium: 30,
          fertility: '165 mg/kg',
          kwhValue: defaultKwh,
        ),
        HistoryItem(
            id: 't1',
            time: "04:00",
            date: todayDateString,
            location: defaultLocation,
            temperature: 22.0,
            humidity: 5.0,
            ph: 6.9,
            conductivity: 8.1,
            nitrogen: 11,
            phosphor: 50,
            kalium: 21,
            fertility: '168 mg/kg',
            kwhValue: 45.0),
        HistoryItem(
            id: 't2',
            time: "08:30",
            date: todayDateString,
            location: defaultLocation,
            temperature: 24.5,
            humidity: 4.5,
            ph: 7.0,
            conductivity: 8.3,
            nitrogen: 12,
            phosphor: 51,
            kalium: 22,
            fertility: '170 mg/kg',
            kwhValue: 45.0),
        HistoryItem(
            id: 't3',
            time: "12:15",
            date: todayDateString,
            location: defaultLocation,
            temperature: 27.0,
            humidity: 3.8,
            ph: 7.1,
            conductivity: 8.6,
            nitrogen: 13,
            phosphor: 53,
            kalium: 23,
            fertility: '172 mg/kg',
            kwhValue: 45.0),
        HistoryItem(
            id: 't4',
            time: "16:45",
            date: todayDateString,
            location: defaultLocation,
            temperature: 25.0,
            humidity: 4.2,
            ph: 7.0,
            conductivity: 8.4,
            nitrogen: 12,
            phosphor: 52,
            kalium: 22,
            fertility: '170 mg/kg',
            kwhValue: 45.0),
        HistoryItem(
            id: 't5',
            time: "20:00",
            date: todayDateString,
            location: defaultLocation,
            temperature: 23.0,
            humidity: 5.5,
            ph: 7.0,
            conductivity: 8.0,
            nitrogen: 11,
            phosphor: 50,
            kalium: 21,
            fertility: '168 mg/kg',
            kwhValue: 45.0),
      ],
    );
    _historyData.sort((a, b) => a.timeAsDouble.compareTo(b.timeAsDouble));
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _addHistory() {
    final now = DateTime.now();
    final newEntry = HistoryItem(
      id: 'n${now.microsecondsSinceEpoch}',
      time:
          "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}",
      date:
          "${_getDayName(now.weekday)}, ${now.day} ${_getMonthName(now.month)} ${now.year}",
      location: defaultLocation,
      temperature: defaultTemperature,
      humidity: defaultHumidity,
      ph: defaultPh,
      conductivity: defaultConductivity,
      nitrogen: defaultN,
      phosphor: defaultP,
      kalium: defaultK,
      fertility: defaultFertility,
      kwhValue: defaultKwh,
    );

    setState(() {
      _historyData.insert(0, newEntry);
      _historyData.sort((a, b) => a.timeAsDouble.compareTo(b.timeAsDouble));
    });
  }

  void _navigateToHome() {
    setState(() {
      _currentIndex = 0;
    });
  }

  String _getDayName(int weekday) {
    const days = [
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
      'Minggu',
    ];
    if (weekday < 1 || weekday > 7) return '';
    return days[weekday - 1];
  }

  String _getMonthName(int month) {
    const months = [
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
    if (month < 1 || month > 12) return '';
    return months[month - 1];
  }

  // --- PERBAIKAN 1: Logika listener diubah ---
  void _scrollListener() {
    // Hapus 'if (_currentIndex != 0 ...)'
    if (!_scrollController.hasClients) return;

    final direction = _scrollController.position.userScrollDirection;

    // Jika scroll ke atas (forward) atau sudah mentok di atas
    if (direction == ScrollDirection.forward || _scrollController.offset <= 0) {
      if (!_isNavBarVisible) {
        setState(() => _isNavBarVisible = true);
      }
    }
    // Jika scroll ke bawah (reverse)
    else if (direction == ScrollDirection.reverse) {
      if (_isNavBarVisible) {
        setState(() => _isNavBarVisible = false);
      }
    }
  }

  // --- PERBAIKAN 2: Kirim scrollController ke SEMUA screen ---
  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return HomeScreen(
          scrollController: _scrollController,
          onSave: _addHistory,
        );
      case 1:
        return HistoryScreen(
          scrollController: _scrollController, // <-- DITAMBAHKAN
          historyData: _historyData,
          // onDelete dihapus
        );
      case 2:
        return ProfileScreen(
          scrollController: _scrollController, // <-- DITAMBAHKAN
          onBack: _navigateToHome,
        );
      default:
        return HomeScreen(
          scrollController: _scrollController,
          onSave: _addHistory,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Warna kanvas F9F9F9 sudah ada di sini
      backgroundColor: const Color(0xFFF9F9F9),
      body: Stack(
        children: [
          _buildPage(_currentIndex),
          // Navbar sekarang selalu ada (if-nya sudah dihapus)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildFloatingNavBar(),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingNavBar() {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      transform: Matrix4.translationValues(0, _isNavBarVisible ? 0 : 150, 0),
      child: Container(
        margin: EdgeInsets.fromLTRB(
          20,
          20,
          20,
          bottomPadding > 0 ? bottomPadding : 10,
        ),
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(35),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(25),
              blurRadius: 20,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(35),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: GNav(
              selectedIndex: _currentIndex,
              onTabChange: (index) => setState(() {
                _currentIndex = index;
                _isNavBarVisible = true;

                // --- PERBAIKAN 3: Reset scroll position saat ganti tab ---
                if (_scrollController.hasClients &&
                    _scrollController.offset > 0) {
                  _scrollController.jumpTo(0);
                }
                // --------------------------------------------------------
              }),
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              padding: const EdgeInsets.all(12),
              gap: 8,
              activeColor: Colors.white,
              color: const Color(0xFFF07F2F),
              tabBackgroundColor: const Color(0xFFF07F2F),
              tabBorderRadius: 25,
              tabs: const [
                GButton(icon: Icons.home, text: 'Utama'),
                GButton(icon: Icons.access_time, text: 'History'),
                GButton(icon: Icons.person_outline, text: 'Profil'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
