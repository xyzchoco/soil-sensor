import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

// Class Model HistoryItem tetap sama
class HistoryItem {
  final String id;
  final String time; // Diasumsikan format "HH:MM"
  final String date;
  final String location;
  final double temperature;
  final double humidity;
  final double ph;
  final double conductivity;
  final int nitrogen;
  final int kalium;
  final int phosphor;
  final String fertility;
  final double kwhValue;

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
    required this.kwhValue,
  });

  double get timeAsDouble {
    try {
      final parts = time.split(':');
      final hour = double.parse(parts[0]);
      final minute = double.parse(parts[1]);
      return hour + (minute / 60.0);
    } catch (e) {
      return 0.0;
    }
  }
}

class HistoryScreen extends StatefulWidget {
  final List<HistoryItem> historyData;
  final Function(String itemId)? onDelete;
  final ScrollController scrollController;

  const HistoryScreen({
    super.key,
    required this.historyData,
    this.onDelete,
    required this.scrollController,
  });

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late String _selectedDay;
  late String _selectedMonth;
  late String _selectedYear;

  final List<String> _days =
      List.generate(31, (index) => (index + 1).toString());
  final List<String> _months = [
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
    'Desember'
  ];
  final List<String> _years =
      List.generate(5, (index) => (DateTime.now().year - index).toString());

  static const Color canvasColor = Color(0xFFF9F9F9);
  static const String defaultFont = 'Poppins';

  List<HistoryItem> filteredData = [];

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedDay = now.day.toString();
    _selectedMonth = _months[now.month - 1];
    _selectedYear = now.year.toString();

    widget.historyData.sort((a, b) => a.timeAsDouble.compareTo(b.timeAsDouble));
    _filterData();
  }

  void _filterData() {
    final monthIndex = _months.indexOf(_selectedMonth) + 1;
    if (monthIndex == 0) return;
    final selectedDateString =
        "$_selectedDay ${_months[monthIndex - 1]} $_selectedYear";

    setState(() {
      filteredData = widget.historyData.where((item) {
        try {
          final itemDatePart =
              item.date.substring(item.date.indexOf(',') + 2).trim();
          return itemDatePart == selectedDateString;
        } catch (e) {
          print("Error parsing date: ${item.date} - $e");
          return false;
        }
      }).toList();
      filteredData.sort((a, b) => a.timeAsDouble.compareTo(b.timeAsDouble));
    });
  }

  List<FlSpot> _getSpotsForChart(DataType type) {
    if (filteredData.isEmpty) {
      return [];
    }

    return filteredData.map((item) {
      final x = item.timeAsDouble;
      final y =
          (type == DataType.temperature) ? item.temperature : item.conductivity;
      return FlSpot(x, y);
    }).toList();
  }

  double _getMinY(DataType type) {
    if (filteredData.isEmpty) return 0;
    try {
      final values = filteredData.map((e) =>
          (type == DataType.temperature) ? e.temperature : e.conductivity);
      if (values.isEmpty) return 0;
      final minValue = values.reduce(min);
      return max(0, minValue - (minValue.abs() * 0.1));
    } catch (e) {
      return 0;
    }
  }

  double _getMaxY(DataType type) {
    if (filteredData.isEmpty) return (type == DataType.temperature) ? 40 : 15;
    try {
      final values = filteredData.map((e) =>
          (type == DataType.temperature) ? e.temperature : e.conductivity);
      if (values.isEmpty) return (type == DataType.temperature) ? 40 : 15;
      final maxValue = values.reduce(max);
      return maxValue + (maxValue.abs() * 0.1);
    } catch (e) {
      return (type == DataType.temperature) ? 40 : 15;
    }
  }

  @override
  Widget build(BuildContext context) {
    final temperatureSpots = _getSpotsForChart(DataType.temperature);
    final conductivitySpots = _getSpotsForChart(DataType.conductivity);

    return Scaffold(
      backgroundColor: canvasColor,
      body: SafeArea(
        child: SingleChildScrollView(
          controller: widget.scrollController,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 35),
                const Center(
                  child: Text(
                    'History',
                    style: TextStyle(
                      fontFamily: defaultFont,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 45),
                _buildChartCard(
                  title: 'Temperature',
                  gradientColors: const [
                    Color(0xFFF07F2F),
                    Color(0xFFECAB47),
                  ],
                  lineColor: const Color(0xFFFFD900),
                  spots: temperatureSpots,
                  dataType: DataType.temperature,
                  minY: _getMinY(DataType.temperature),
                  maxY: _getMaxY(DataType.temperature),
                ),
                const SizedBox(height: 45),
                _buildChartCard(
                  title: 'Daya Hantar Listrik',
                  gradientColors: const [
                    Color(0xFF5A65FF),
                    Color(0xFF2BC2FF),
                  ],
                  lineColor: Colors.white,
                  spots: conductivitySpots,
                  dataType: DataType.conductivity,
                  minY: _getMinY(DataType.conductivity),
                  maxY: _getMaxY(DataType.conductivity),
                ),
                const SizedBox(height: 90),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChartCard({
    required String title,
    required List<Color> gradientColors,
    required Color lineColor,
    required List<FlSpot> spots,
    required DataType dataType,
    required double minY,
    required double maxY,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: defaultFont,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 15),
        Container(
          clipBehavior: Clip.antiAlias,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: gradientColors[1].withOpacity(0.2),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildDateDropdowns(),
              const SizedBox(height: 25),
              SizedBox(
                height: 150,
                child: spots.isEmpty
                    ? Center(
                        child: Text(
                          'Tidak ada data untuk tanggal ini.',
                          style: TextStyle(
                              // ignore: deprecated_member_use
                              color: Colors.white.withOpacity(0.7),
                              fontFamily: defaultFont),
                        ),
                      )
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        // --- PERBAIKAN 1: Izinkan widget ini menggambar di luar batasnya ---
                        clipBehavior: Clip.none,
                        // --------------------------------------------------------------
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 2.5,
                          child: _buildLineChart(
                              spots, lineColor, dataType, minY, maxY),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDateDropdowns() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildDropdown(_days, _selectedDay, (value) {
          if (value != null && value != _selectedDay) {
            setState(() => _selectedDay = value);
            _filterData();
          }
        }),
        const SizedBox(width: 8),
        _buildDropdown(_months, _selectedMonth, (value) {
          if (value != null && value != _selectedMonth) {
            setState(() => _selectedMonth = value);
            _filterData();
          }
        }),
        const SizedBox(width: 8),
        _buildDropdown(_years, _selectedYear, (value) {
          if (value != null && value != _selectedYear) {
            setState(() => _selectedYear = value);
            _filterData();
          }
        }),
      ],
    );
  }

  Widget _buildDropdown(List<String> items, String selectedValue,
      ValueChanged<String?> onChanged) {
    final String effectiveValue =
        items.contains(selectedValue) ? selectedValue : items.first;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: effectiveValue,
          icon:
              const Icon(Icons.arrow_drop_down, color: Colors.white, size: 20),
          dropdownColor: Colors.black87,
          style: const TextStyle(
              fontFamily: defaultFont, color: Colors.white, fontSize: 12),
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: onChanged,
          isDense: true,
        ),
      ),
    );
  }

  // --- WIDGET UNTUK LINE CHART (GRID & TITLES DIUBAH) ---
  Widget _buildLineChart(List<FlSpot> spots, Color lineColor, DataType dataType,
      double minY, double maxY) {
    if (spots.isEmpty) {
      return Container();
    }

    final double adjustedMaxY = (maxY <= minY) ? minY + 5 : maxY;

    // --- INI ADALAH LOGIKA ANDA UNTUK 5 GARIS (SUDAH BENAR) ---
    final double range = adjustedMaxY - minY;
    final double horizontalInterval =
        range > 0 ? range / 4 : 1; // Paksa 4 interval (5 garis)
    // -----------------------------------------------------------

    return LineChart(
      LineChartData(
        minY: minY,
        maxY: adjustedMaxY,
        minX: -0.5,
        maxX: 24.5,

        // --- PERBAIKAN 2: Beri tahu chart agar tidak memotong bagian atas ---
        clipData: const FlClipData(
          top: false, // <-- Ini kuncinya
          bottom: true,
          left: true,
          right: true,
        ),
        // -----------------------------------------------------------------

        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          drawHorizontalLine: true,
          horizontalInterval:
              horizontalInterval, // <-- Logika 5 garis Anda (sudah benar)
          getDrawingHorizontalLine: (value) {
            return const FlLine(
              color: Colors.white,
              strokeWidth: 1,
            );
          },
        ),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          // --- INI ADALAH LOGIKA ANDA UNTUK TANPA JARAK (SUDAH BENAR) ---
          leftTitles: const AxisTitles(
              sideTitles: SideTitles(
                  showTitles: false, reservedSize: 0)), // <-- Sudah benar
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(
              sideTitles: SideTitles(
                  showTitles: false, reservedSize: 0)), // <-- Sudah benar
          // -------------------------------------------
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 17,
              interval: 2.0, // <-- PERUBAHAN: Diubah dari 4 ke 1.0
              getTitlesWidget: _getBottomTitles,
            ),
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: lineColor,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(show: false),
          ),
        ],
        lineTouchData: LineTouchData(
          enabled: true,
          touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (LineBarSpot touchedSpot) {
                return Colors.white;
              },
              tooltipRoundedRadius: 8,
              getTooltipItems: (touchedSpots) {
                return touchedSpots
                    .map((LineBarSpot touchedSpot) {
                      if (touchedSpot.spotIndex < 0 ||
                          touchedSpot.spotIndex >= filteredData.length) {
                        return null;
                      }
                      final relatedItem = filteredData[touchedSpot.spotIndex];

                      final textStyle = TextStyle(
                        color: (dataType == DataType.temperature)
                            ? Colors.orange.shade800
                            : Colors.blue.shade800,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        fontFamily: defaultFont,
                      );
                      String text;
                      if (dataType == DataType.temperature) {
                        text =
                            '${relatedItem.temperature.toStringAsFixed(1)} C';
                      } else {
                        text =
                            '${relatedItem.conductivity.toStringAsFixed(1)} µS/cm';
                      }
                      return LineTooltipItem(text, textStyle);
                    })
                    .where((item) => item != null)
                    .cast<LineTooltipItem>()
                    .toList();
              }),
          handleBuiltInTouches: true,
          getTouchedSpotIndicator: (barData, spotIndexes) {
            return spotIndexes.map((spotIndex) {
              if (spotIndex < 0 || spotIndex >= barData.spots.length) {
                return TouchedSpotIndicatorData(
                    FlLine(color: Colors.transparent), FlDotData(show: false));
              }
              return TouchedSpotIndicatorData(
                FlLine(color: Colors.white, strokeWidth: 2),
                FlDotData(
                  getDotPainter: (spot, percent, barData, index) {
                    return FlDotCirclePainter(
                      radius: 6,
                      color: Colors.white,
                      strokeWidth: 2,
                      strokeColor: lineColor,
                    );
                  },
                ),
              );
            }).toList();
          },
        ),
      ),
      duration: const Duration(milliseconds: 250),
    );
  }

  // --- WIDGET HELPER UNTUK JUDUL BAWAH (X AXIS) ---
  // --- INI ADALAH FUNGSI YANG DIPERBARUI ---
  Widget _getBottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white70,
      fontWeight: FontWeight.w500,
      fontSize: 10,
      fontFamily: defaultFont,
    );

    final hour = value.toInt();

    // PERUBAHAN: Hanya tampilkan label jika nilainya adalah jam pas (integer)
    if (value != hour.toDouble()) {
      return Container(); // Sembunyikan label untuk non-integer (cth: 1.5, 2.5)
    }

    // Hindari tumpang tindih di akhir (misal 24.0)
    if (value >= meta.max) {
      return Container();
    }

    // Format teks menjadi "HH:00"
    final String text = '${hour.toString().padLeft(2, '0')}:00';

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }
} // End of _HistoryScreenState

// Enum untuk membedakan tipe data chart
enum DataType { temperature, conductivity }
