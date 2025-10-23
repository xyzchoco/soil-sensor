// features/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'notification_screen.dart'; // Impor halaman notifikasi

class HomeScreen extends StatefulWidget {
  final ScrollController scrollController;
  final VoidCallback? onSave;

  const HomeScreen({super.key, required this.scrollController, this.onSave});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showSuccess = false;

  @override
  Widget build(BuildContext context) {
    // Pilihan: Sembunyikan pop-up sukses otomatis setelah 3 detik
    if (showSuccess) {
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            showSuccess = false;
          });
        }
      });
    }

    return SafeArea(
      child: SingleChildScrollView(
        controller: widget.scrollController,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              showSuccess ? _buildSuccessPopUp() : _buildHeader(context),
              const SizedBox(height: 20),
              _buildWeatherCard(),
              const SizedBox(height: 20),
              _buildStatistikaHeader(),
              const SizedBox(height: 20),
              _buildMainStatsCard(), // Widget ini telah dimodifikasi
              const SizedBox(height: 20),
              _buildNpkCards(),
              const SizedBox(height: 20),
              _buildKesuburanCard(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome', style: TextStyle(color: Colors.grey)),
            Text(
              'Raja Iblis Jahat',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        // PERBAIKAN: Menambahkan navigasi ke halaman Notifikasi
        IconButton(
          icon: const Icon(Icons.notifications_none_outlined, size: 28),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NotificationScreen(),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSuccessPopUp() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color.fromARGB(255, 79, 186, 29),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0x0D000000),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF56AB2F), size: 28),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Data Berhasil Disimpan',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                showSuccess = false;
              });
            },
            child: const Icon(Icons.close, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 170,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF07F2F), Color(0xFFECAB47)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              // Asumsi aset ini tersedia di proyek Anda
              child: Image.asset(
                'assets/images/box_weather.png',
                height: 170,
                fit: BoxFit.cover,
              ),
            ),
            const Positioned.fill(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.white, size: 18),
                        SizedBox(width: 6),
                        Text(
                          'Politeknik negeri Lampung',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Kamis, 9 Oktober 2025 | 16:28',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    Spacer(),
                    Text(
                      '24°C',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatistikaHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Statistika',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              showSuccess = true;
            });
            // Panggil fungsi penyimpanan data di widget parent
            widget.onSave?.call();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text('Simpan Data'),
        ),
      ],
    );
  }

  // --- MODIFIKASI DIMULAI DI SINI ---
  Widget _buildMainStatsCard() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0x1A000000),
            spreadRadius: 1,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            // <-- DITAMBAHKAN ROW
            children: [
              Expanded(
                // <-- DITAMBAHKAN EXPANDED
                child: SizedBox(
                  height: 150,
                  child: SfRadialGauge(
                    axes: <RadialAxis>[
                      RadialAxis(
                        minimum: 0,
                        maximum: 40,
                        showLabels: false,
                        showTicks: false,
                        startAngle: 165,
                        endAngle: 15,
                        axisLineStyle: const AxisLineStyle(
                          thickness: 0.2,
                          cornerStyle: CornerStyle.bothCurve,
                          color: Color(0xFFE8E8E8),
                          thicknessUnit: GaugeSizeUnit.factor,
                        ),
                        pointers: const <GaugePointer>[
                          RangePointer(
                            value: 24,
                            width: 0.2,
                            sizeUnit: GaugeSizeUnit.factor,
                            cornerStyle: CornerStyle.bothCurve,
                            gradient: SweepGradient(
                              colors: <Color>[
                                Color(0xFFF07F2F),
                                Color(0xFFF28E27),
                                Color(0xFFFAB911),
                                Color(0xFFFFD900),
                              ],
                              stops: [0.0, 0.33, 0.66, 1.0],
                            ),
                          ),
                        ],
                        annotations: <GaugeAnnotation>[
                          GaugeAnnotation(
                            widget: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '24°C',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Temperatur',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12, // <-- FONT DIUBAH DI SINI
                                  ),
                                ),
                              ],
                            ),
                            angle: 90,
                            positionFactor: 0,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                // <-- WIDGET BARU DITAMBAHKAN DI SINI
                child: SizedBox(
                  height: 150,
                  child: _buildDhlGauge(), // Memanggil helper gauge baru
                ),
              ),
            ],
          ),
          Transform.translate(
            offset: const Offset(0, -25),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // CircularStat yang sudah diperbaiki untuk kesejajaran
                _CircularStat(
                  value: 4.0, // Diubah ke float untuk 1 desimal
                  title: 'Kelembapan Tanah (%)',
                  color: Color(0xFF7B61FF),
                  max: 10, // Max disetel untuk gauge
                ),
                _CircularStat(
                  value: 7.0, // Diubah ke float untuk 1 desimal
                  title: 'Tingkat pH tanah',
                  color: Color(0xFF7ED957),
                  max: 14, // Max pH 14
                ),
                _CircularStat(
                  value: 8.5,
                  title:
                      'Daya Hantar Listrik (µS/cm)', // Title lengkap untuk lebar
                  color: Color(0xFFFF6B6B),
                  max: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGET HELPER BARU DITAMBAHKAN DI SINI ---
  Widget _buildDhlGauge() {
    // Ini adalah widget baru untuk Daya Hantar Listrik (kwh)
    // Saya menggunakan nilai placeholder (45 kwh) dan max 100
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          minimum: 0,
          maximum: 100, // Placeholder max untuk kwh
          showLabels: false,
          showTicks: false,
          startAngle: 165,
          endAngle: 15,
          axisLineStyle: const AxisLineStyle(
            thickness: 0.2,
            cornerStyle: CornerStyle.bothCurve,
            color: Color(0xFFE8E8E8),
            thicknessUnit: GaugeSizeUnit.factor,
          ),
          pointers: const <GaugePointer>[
            RangePointer(
              value: 45, // Placeholder value
              width: 0.2,
              sizeUnit: GaugeSizeUnit.factor,
              cornerStyle: CornerStyle.bothCurve,
              gradient: SweepGradient(
                // Warna baru
                colors: <Color>[
                  Color(0xFF7B61FF),
                  Color(0xFFA6B4FF),
                ],
                stops: [0.0, 1.0],
              ),
            ),
          ],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
              widget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '45 kwh', // Teks baru
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Daya Hantar Listrik', // Teks baru
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12, // <-- FONT DIUBAH DI SINI
                    ),
                  ),
                ],
              ),
              angle: 90,
              positionFactor: 0,
            ),
          ],
        ),
      ],
    );
  }
  // --- MODIFIKASI BERAKHIR DI SINI ---

  Widget _buildNpkCards() {
    return const Row(
      children: [
        Expanded(
          child: _NpkCard(
            value: 12,
            unit: 'N',
            color: Color(0xFFFD9A9A),
            title: 'Nitrogen',
          ),
        ),
        SizedBox(width: 15),
        Expanded(
          child: _NpkCard(
            value: 52,
            unit: 'P',
            color: Color(0xFF8C9EFF),
            title: 'Fosfor',
          ),
        ),
        SizedBox(width: 15),
        Expanded(
          child: _NpkCard(
            value: 22,
            unit: 'K',
            color: Color(0xFF80DEEA),
            title: 'Kalium',
          ),
        ),
      ],
    );
  }

  Widget _buildKesuburanCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFFA8E063), Color(0xFF56AB2F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Kesuburan Tanah (mg/kg)',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                '170 mg/kg',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Transform.scale(
            scale: 1.2,
            child: FittedBox(
              fit: BoxFit.contain,
              // Asumsi aset ini tersedia di proyek Anda
              child: Image.asset('assets/images/icon_tumbuhan.png'),
            ),
          ),
        ],
      ),
    );
  }
}

// =========================================================================
// CLASS PEMBANTU DENGAN PERBAIKAN SEJAJAR
// =========================================================================

class _CircularStat extends StatelessWidget {
  final double value;
  final String title;
  final Color color;
  final double max;

  const _CircularStat({
    required this.value,
    required this.title,
    required this.color,
    this.max = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 70,
          width: 70,
          child: SfRadialGauge(
            axes: <RadialAxis>[
              RadialAxis(
                minimum: 0,
                maximum: max,
                showLabels: false,
                showTicks: false,
                startAngle: 0,
                endAngle: 360,
                axisLineStyle: const AxisLineStyle(
                  thickness: 0.3,
                  color: Colors.transparent,
                  thicknessUnit: GaugeSizeUnit.factor,
                ),
                pointers: <GaugePointer>[
                  RangePointer(
                    value: max,
                    width: 0.3,
                    sizeUnit: GaugeSizeUnit.factor,
                    color: color.withAlpha(51),
                    enableAnimation: false,
                  ),
                  RangePointer(
                    value: value > max ? max : value,
                    width: 0.3,
                    sizeUnit: GaugeSizeUnit.factor,
                    color: color,
                  ),
                ],
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                    widget: Text(
                      value.toStringAsFixed(value % 1 == 0 ? 0 : 1),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    angle: 90,
                    positionFactor: 0.1,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // PERBAIKAN: Menggunakan SizedBox dengan lebar tetap untuk kesejajaran
        SizedBox(
          width: 90,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ),
      ],
    );
  }
}

class _NpkCard extends StatelessWidget {
  final int value;
  final String unit;
  final Color color;
  final String title;
  const _NpkCard({
    required this.value,
    required this.unit,
    required this.color,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          RichText(
            text: TextSpan(
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
              children: [
                TextSpan(text: '$value', style: const TextStyle(fontSize: 28)),
                const TextSpan(text: '/kg', style: TextStyle(fontSize: 14)),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$title ($unit)',
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
