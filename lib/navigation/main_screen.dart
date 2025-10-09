// main_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

// Pastikan path ini sesuai dengan struktur folder proyek Anda
import 'package:soil/features/screens/home_screen.dart';
import 'package:soil/features/screens/history_screen.dart';
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

  final List<HistoryItem> _historyData = [];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);

    _historyData.addAll(
      [
        HistoryItem(
          id: 'h${DateTime.now().microsecondsSinceEpoch + 100}',
          time: "15:00",
          date: "${_getDayName(DateTime.tuesday)}, 20 Oktober 2025",
          location: defaultLocation,
          temperature: 26.0,
          humidity: 6.2,
          ph: 6.8,
          conductivity: 7.9,
          nitrogen: 12,
          phosphor: 52,
          kalium: 22,
          fertility: defaultFertility,
        ),
        HistoryItem(
          id: 'k${DateTime.now().microsecondsSinceEpoch + 200}',
          time: "20:00",
          date: "${_getDayName(DateTime.monday)}, 19 Oktober 2025",
          location: 'Kebun Percobaan Natar',
          temperature: 25.5,
          humidity: 4.0,
          ph: 7.0,
          conductivity: 8.5,
          nitrogen: 15,
          phosphor: 40,
          kalium: 30,
          fertility: '165 mg/kg',
        ),
      ].reversed.toList(),
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _deleteHistoryItem(String id) {
    setState(() {
      _historyData.removeWhere((item) => item.id == id);
    });
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
    );

    setState(() {
      _historyData.insert(0, newEntry);
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
    return months[month - 1];
  }

  void _scrollListener() {
    if (_currentIndex != 0 || !_scrollController.hasClients) return;
    final direction = _scrollController.position.userScrollDirection;
    if (direction == ScrollDirection.reverse && _isNavBarVisible) {
      setState(() => _isNavBarVisible = false);
    } else if (direction == ScrollDirection.forward && !_isNavBarVisible) {
      setState(() => _isNavBarVisible = true);
    }
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return HomeScreen(
          scrollController: _scrollController,
          onSave: _addHistory,
        );
      case 1:
        return HistoryScreen(
          historyData: _historyData,
          onDelete: _deleteHistoryItem,
        );
      case 2:
        // PERBAIKAN: Memberikan fungsi _navigateToHome ke parameter onBack.
        return ProfileScreen(onBack: _navigateToHome);
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
      body: Stack(
        children: [
          _buildPage(_currentIndex),
          if (_currentIndex != 2)
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
                if (index != 0 && _scrollController.hasClients) {
                  _scrollController.jumpTo(0);
                }
              }),
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              padding: const EdgeInsets.all(12),
              gap: 8,
              activeColor: Colors.white,
              color: Colors.orange,
              tabBackgroundColor: Colors.orange,
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
