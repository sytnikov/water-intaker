import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_intake/bars/bar_graph.dart';
import 'package:water_intake/data/water_data.dart';

class WaterIntakeSummary extends StatelessWidget {
  final DateTime startOfWeek;
  const WaterIntakeSummary({super.key, required this.startOfWeek});

  @override
  Widget build(BuildContext context) {
    return Consumer<WaterData>(
      builder: (context, value, child) => SizedBox(
        height: 200,
        child: BarGraph(
          maxY: 100,
          sunWaterAmt: 19,
          monWaterAmt: 34,
          tueWaterAmt: 6,
          wedWaterAmt: 80,
          thuWaterAmt: 12,
          friWaterAmt: 2,
          satWaterAmt: 65,
        ),
      ),
    );
  }
}
