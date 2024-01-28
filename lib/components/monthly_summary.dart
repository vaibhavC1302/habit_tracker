import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:habit_tracker/datetime/date_time.dart';

class MonthlySummary extends StatelessWidget {
  final Map<DateTime, int>? dataset;
  final String startDate;
  const MonthlySummary(
      {super.key, required this.dataset, required this.startDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: HeatMap(
        startDate: createDateTimeObject(startDate),
        endDate: DateTime.now().add(const Duration(days: 0)),
        datasets: dataset,
        colorMode: ColorMode.color,
        defaultColor: Colors.grey[200],
        textColor: Colors.black,
        showColorTip: false,
        showText: true,
        scrollable: true,
        size: 30,
        colorsets: {
          1: Colors.white,
          2: Colors.purple[100]!,
          3: Colors.purple[200]!,
          4: Colors.purple[300]!,
          5: Colors.purple[400]!,
          6: Colors.purple[500]!,
          7: Colors.purple[600]!,
          8: Colors.purple[700]!,
          9: Colors.purple[800]!,
          10: Colors.purple[900]!,
        },
      ),
    );
  }
}
