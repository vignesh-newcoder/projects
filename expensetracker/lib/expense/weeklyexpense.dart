import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expensetracker/expense/expense.dart';
import 'package:expensetracker/BarChart/individualbar.dart';
import 'package:expensetracker/BarChart/bar_graph.dart';

class Weeklyexpense extends StatelessWidget {
  final DateTime startOfWeek;
  final VoidCallback onPreviousWeek;
  final VoidCallback onNextWeek;

  const Weeklyexpense({
    super.key,
    required this.startOfWeek,
    required this.onPreviousWeek,
    required this.onNextWeek,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<Expense>(
      builder: (context, expense, _) {
        final weeklyData = expense.calculateWeeklyTotalsForMonth(
          startOfWeek.year,
          startOfWeek.month,
        );

        final bars = List.generate(
          5,
          (index) => Individualbar(
            x: index,
            y: weeklyData[index + 1] ?? 0,
          ),
        );

        final total = bars.fold(0.0, (sum, bar) => sum + bar.y);

        final maxY = bars.map((b) => b.y).reduce((a, b) => a > b ? a : b);

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            Text(
              'Overall Weekly Expenses',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 40),
            SizedBox(
              height: 220,
              child: BarGraph(
                bars: bars,
                maxY: maxY,
                labels: List.generate(
                  bars.length,
                  (i) => "W${i + 1}",
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Weekly Total: ₹ ${total.toStringAsFixed(0)}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
    );
  }
}
