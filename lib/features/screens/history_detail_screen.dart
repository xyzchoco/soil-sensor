// history_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'history_screen.dart' show HistoryItem;

class HistoryDetailScreen extends StatefulWidget {
  final HistoryItem item;
  final Function(String itemId)? onDelete;

  const HistoryDetailScreen({super.key, required this.item, this.onDelete});

  @override
  State<HistoryDetailScreen> createState() => _HistoryDetailScreenState();
}

class _HistoryDetailScreenState extends State<HistoryDetailScreen> {
  bool showDeleteSuccess = false;

  @override
  Widget build(BuildContext context) {
    if (showDeleteSuccess) {
      Future.delayed(const Duration(milliseconds: 700), () {
        if (mounted) {
          if (widget.onDelete != null) {
            widget.onDelete!(widget.item.id);
          }
          Navigator.of(context).pop();
        }
      });
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Konten utama yang dapat di-scroll
            SingleChildScrollView(
              // PERBAIKAN: Padding global dihapus dari sini
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Padding ditambahkan secara individual ke header
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: _buildHeader(context, widget.item),
                  ),
                  const SizedBox(height: 20),
                  // Padding ditambahkan secara individual ke kartu statistik
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: _buildMainStatsCard(widget.item),
                  ),
                  const SizedBox(height: 20),
                  // Padding ditambahkan secara individual ke kartu NPK
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: _buildNpkCards(widget.item),
                  ),
                  const SizedBox(height: 20),
                  // Kartu kesuburan tidak diberi padding agar bisa penuh
                  _buildKesuburanCard(widget.item),
                  const SizedBox(height: 20),
                ],
              ),
            ),

            // Pop-up notifikasi hapus
            if (showDeleteSuccess)
              Positioned(
                top: 10,
                left: 20,
                right: 20,
                child: _buildDeleteSuccessPopUp(),
              ),
          ],
        ),
      ),
    );
  }

  // ... (Sisa kode widget tidak diubah)

  // --- Widget Pop-up "Data Berhasil Dihapus" ---
  Widget _buildDeleteSuccessPopUp() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: const Color.fromARGB(255, 79, 186, 29),
          width: 2,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x20000000),
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF56AB2F), size: 28),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Data Berhasil Dihapus',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (widget.onDelete != null) {
                widget.onDelete!(widget.item.id);
              }
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.close, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  // --- Widget Header ---
  Widget _buildHeader(BuildContext context, HistoryItem item) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  size: 28,
                  color: Colors.grey,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            const Text(
              'History',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 48), // Spacer
          ],
        ),
        const SizedBox(height: 55),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${item.date} | ${item.time}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.grey,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        item.location,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    showDeleteSuccess = true;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF07F2F),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                ),
                child: const Text('Hapus Data'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- Widget Statistik Utama ---
  Widget _buildMainStatsCard(HistoryItem item) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            spreadRadius: 1,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
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
                  pointers: <GaugePointer>[
                    RangePointer(
                      value: item.temperature,
                      width: 0.2,
                      sizeUnit: GaugeSizeUnit.factor,
                      cornerStyle: CornerStyle.bothCurve,
                      gradient: const SweepGradient(
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
                            '${item.temperature.toStringAsFixed(0)}°C',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'Temperatur',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      angle: 90,
                      positionFactor: 0.1,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _CircularStat(
                  value: item.humidity,
                  title: 'Kelembapan Tanah (%)',
                  color: const Color(0xFF7B61FF),
                  max: 100,
                ),
                _CircularStat(
                  value: item.ph,
                  title: 'Tingkat pH tanah',
                  color: const Color(0xFF7ED957),
                  max: 14,
                ),
                _CircularStat(
                  value: item.conductivity,
                  title: 'Daya Hantar Listrik (μS/cm)',
                  color: const Color(0xFFFF6B6B),
                  max: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Widget NPK Cards ---
  Widget _buildNpkCards(HistoryItem item) {
    return Row(
      children: [
        _NpkCard(
          value: item.nitrogen,
          unit: 'N',
          color: const Color(0xFFFD9A9A),
          title: 'Nitrogen',
        ),
        const SizedBox(width: 15),
        _NpkCard(
          value: item.phosphor,
          unit: 'P',
          color: const Color(0xFF8C9EFF),
          title: 'Fosfor',
        ),
        const SizedBox(width: 15),
        _NpkCard(
          value: item.kalium,
          unit: 'K',
          color: const Color(0xFF80DEEA),
          title: 'Kalium',
        ),
      ],
    );
  }

  // --- Widget Kesuburan ---
  Widget _buildKesuburanCard(HistoryItem item) {
    return Container(
      // PERBAIKAN: Margin ditambahkan agar ada jarak dari tepi layar
      margin: const EdgeInsets.symmetric(horizontal: 20),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Kesuburan Tanah (mg/kg)',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                item.fertility,
                style: const TextStyle(
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
}

// ... (Widget _CircularStat dan _NpkCard tidak diubah)

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
                      value.toStringAsFixed(1),
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
                  fontFamily: 'Poppins',
                ),
                children: [
                  TextSpan(
                    text: '$value',
                    style: const TextStyle(fontSize: 28),
                  ),
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
      ),
    );
  }
}
