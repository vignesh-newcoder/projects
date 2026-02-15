import 'package:expensetracker/BarChart/individualbar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarGraph extends StatelessWidget {
  final List<Individualbar> bars;
  final double maxY;
  final List<String> labels;

  const BarGraph({
    super.key,
    required this.bars,
    required this.maxY,
    required this.labels,
  });

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        minY: 0,
        maxY: maxY,
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value.toInt() < labels.length) {
                  return Text(
                    labels[value.toInt()],
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
        barGroups: bars
            .map(
              (bar) => BarChartGroupData(
                x: bar.x,
                barRods: [
                  BarChartRodData(
                    toY: bar.y,
                    width: 18,
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.blue,
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      toY: maxY,
                      color: Colors.grey.shade300,
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
