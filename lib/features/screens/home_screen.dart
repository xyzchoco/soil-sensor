// features/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
// Import notification_screen.dart bisa dihapus jika tidak dipakai lagi
// import 'notification_screen.dart';

class HomeScreen extends StatefulWidget {
  final ScrollController scrollController;
  final VoidCallback? onSave;

  const HomeScreen({super.key, required this.scrollController, this.onSave});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showSuccess = false;

  // Definisikan warna dasar dan font
  static const Color canvasColor = Color(0xFFF9F9F9);
  static const String defaultFont = 'Poppins';

  @override
  Widget build(BuildContext context) {
    if (showSuccess) {
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            showSuccess = false;
          });
        }
      });
    }

    return Scaffold(
      backgroundColor: canvasColor,
      body: SafeArea(
        child: SingleChildScrollView(
          controller: widget.scrollController,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                // Tampilkan pop-up atau header
                if (showSuccess)
                  _buildSuccessPopUp()
                else
                  _buildHeader(), // Context tidak perlu lagi
                const SizedBox(height: 25),
                _buildWeatherCard(),
                const SizedBox(height: 30),
                _buildStatistikaHeader(),
                const SizedBox(height: 15),
                _buildMainStatsCard(),
                const SizedBox(height: 110),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- WIDGET HEADER (ICON NOTIFIKASI DIHAPUS) ---
  Widget _buildHeader() {
    return const Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome',
                style: TextStyle(
                    fontFamily: defaultFont, color: Colors.grey, fontSize: 12)),
            Text(
              'Raja Iblis Jahat',
              style: TextStyle(
                fontFamily: defaultFont,
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // --- WIDGET WEATHER CARD (VERSI LAMA) ---
  Widget _buildWeatherCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20), // Radius lama
      child: Container(
        height: 170,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            // Warna gradient lama
            colors: [Color(0xFFF07F2F), Color(0xFFECAB47)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: Image.asset(
                'assets/images/box_weather.png', // Gambar lama
                height: 170,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const SizedBox(width: 170, height: 170), // Placeholder
              ),
            ),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.white, size: 18),
                        SizedBox(width: 6),
                        Text(
                          'Politeknik negeri Lampung',
                          style: TextStyle(
                            fontFamily: defaultFont, // Terapkan font
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      // Data waktu placeholder
                      'Selasa, 28 Oktober 2025 | ${TimeOfDay.now().format(context)}', // Waktu saat ini
                      style: const TextStyle(
                          fontFamily: defaultFont,
                          color: Colors.white,
                          fontSize: 14),
                    ),
                    const Spacer(),
                    const Text(
                      '24°C', // Data suhu placeholder
                      style: TextStyle(
                        fontFamily: defaultFont,
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

  // --- WIDGET STATISTIKA HEADER (VERSI LAMA dengan Tombol Simpan) ---
  Widget _buildStatistikaHeader() {
    return const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Statistika',
            style: TextStyle(
              fontFamily: defaultFont, // Terapkan font
              fontSize: 17,
              fontWeight: FontWeight.w600, // SemiBold seperti desain baru
              color: Colors.black87,
            ),
          ),
        ]);
  }

  // --- WIDGET MAIN STATS CARD (DIUBAH JADI COLUMN) ---
  Widget _buildMainStatsCard() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white, // Background putih
        borderRadius: BorderRadius.circular(25), // Radius besar
        boxShadow: [
          // Shadow tipis
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Gauge Temperatur
          SizedBox(
            height: 180,
            child: _buildTemperatureGauge(),
          ),
          const SizedBox(height: 5), // Jarak antar gauge
          // Gauge KWH
          SizedBox(
            height: 180,
            child: _buildDhlGauge(),
          ),
        ],
      ),
    );
  }

  // --- WIDGET HELPER GAUGE TEMPERATUR (MODIFIKASI: positionFactor dan cornerStyle) ---
  Widget _buildTemperatureGauge() {
    const double temperatureValue = 24;
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          minimum: 0,
          maximum: 40,
          showLabels: false,
          showTicks: false,
          startAngle: 180,
          endAngle: 0,
          radiusFactor: 0.9,
          axisLineStyle: const AxisLineStyle(
            thickness: 0.15,
            cornerStyle: CornerStyle.bothFlat, // <-- DIUBAH DARI bothCurve
            color: Color(0xFFE8E8E8),
            thicknessUnit: GaugeSizeUnit.factor,
          ),
          pointers: const <GaugePointer>[
            RangePointer(
              value: temperatureValue,
              width: 0.15,
              sizeUnit: GaugeSizeUnit.factor,
              cornerStyle: CornerStyle.bothFlat, // <-- DIUBAH DARI bothCurve
              gradient: SweepGradient(
                colors: <Color>[
                  Color(0xFFFFD900),
                  Color(0xFFFAB911),
                  Color(0xFFF28E27),
                ],
                stops: <double>[0.1, 0.5, 1.0],
              ),
            ),
          ],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
              widget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  Text(
                    '${temperatureValue.toStringAsFixed(0)}°C',
                    style: const TextStyle(
                      fontFamily: defaultFont,
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Temperatur',
                    style: TextStyle(
                      fontFamily: defaultFont,
                      color: Colors.grey,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              angle: 90,
              positionFactor:
                  0, // <-- DIUBAH MENJADI LEBIH KECIL (lebih ke tengah)
            ),
          ],
        ),
      ],
    );
  }

  // --- WIDGET HELPER GAUGE KWH (MODIFIKASI: positionFactor dan cornerStyle) ---
  Widget _buildDhlGauge() {
    const double kwhValue = 45;
    const Color baseColor = Color(0xFF800080);
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          minimum: 0,
          maximum: 100,
          showLabels: false,
          showTicks: false,
          startAngle: 180,
          endAngle: 0,
          radiusFactor: 0.9,
          axisLineStyle: const AxisLineStyle(
            thickness: 0.15,
            cornerStyle: CornerStyle.bothFlat, // <-- DIUBAH DARI bothCurve
            color: Color(0xFFE8E8E8),
            thicknessUnit: GaugeSizeUnit.factor,
          ),
          pointers: <GaugePointer>[
            RangePointer(
              value: kwhValue,
              width: 0.15,
              sizeUnit: GaugeSizeUnit.factor,
              cornerStyle: CornerStyle.bothFlat, // <-- DIUBAH DARI bothCurve
              gradient: SweepGradient(stops: const <double>[
                0.0,
                0.39,
                0.81,
                1.0,
              ], colors: <Color>[
                // Gunakan baseColor di sini
                baseColor.withAlpha(255),
                baseColor.withAlpha(128),
                baseColor.withAlpha(77),
                baseColor.withAlpha(51),
              ]),
            ),
          ],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
              widget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  Text(
                    '${kwhValue.toStringAsFixed(0)} Kwh',
                    style: const TextStyle(
                      fontFamily: defaultFont,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Daya Hantar Listrik',
                    style: TextStyle(
                      fontFamily: defaultFont,
                      color: Colors.grey,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              angle: 90,
              positionFactor:
                  0.05, // <-- DIUBAH MENJADI LEBIH KECIL (lebih ke tengah)
            ),
          ],
        ),
      ],
    );
  }

  // --- WIDGET POP UP SUCCESS (FONT DIPERBARUI) ---
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
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
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
                fontFamily: defaultFont, // Terapkan Poppins
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

  // Fungsi _buildNpkCards() dan _buildKesuburanCard() dan class _NpkCard
  // bisa dihapus jika sudah tidak terpakai sama sekali dalam proyek Anda.
  // Untuk saat ini dibiarkan saja dulu.

  // ignore: unused_element
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
                style: TextStyle(
                    fontFamily: defaultFont,
                    color: Colors.white,
                    fontSize: 16), // Font
              ),
              SizedBox(height: 8),
              Text(
                '170 mg/kg',
                style: TextStyle(
                  fontFamily: defaultFont, // Font
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
              child: Image.asset('assets/images/icon_tumbuhan.png'),
            ),
          ),
        ],
      ),
    );
  }
} // END OF _HomeScreenState

// ignore: unused_element
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
    const String defaultFont = 'Poppins';
    return Expanded(
      child: Container(
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
                  fontFamily: defaultFont, // Font
                ),
                children: [
                  TextSpan(
                      text: '$value', style: const TextStyle(fontSize: 28)),
                  const TextSpan(text: '/kg', style: TextStyle(fontSize: 14)),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '$title ($unit)',
              style: const TextStyle(
                  fontFamily: defaultFont,
                  color: Colors.white,
                  fontSize: 14), // Font
            ),
          ],
        ),
      ),
    );
  }
}
