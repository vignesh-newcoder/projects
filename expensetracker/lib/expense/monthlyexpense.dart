import 'package:expensetracker/BarChart/bar_graph.dart';
import 'package:expensetracker/BarChart/individualbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expensetracker/expense/expense.dart';

class ExpenseMonthly extends StatelessWidget {
  final DateTime currentMonth;
  final VoidCallback onPreviousMonth;
  final VoidCallback onNextMonth;

  const ExpenseMonthly({
    super.key,
    required this.currentMonth,
    required this.onPreviousMonth,
    required this.onNextMonth,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<Expense>(
      builder: (context, expense, _) {
        final monthlyData = expense.calculateMonthlyTotalsForYear(currentMonth.year);

        final bars = List.generate(
          12,
          (index) => Individualbar(
            x: index,
            y: monthlyData[index + 1] ?? 0,
          ),
        );

        final maxY = bars.map((b) => b.y).reduce((a, b) => a > b ? a : b);

        return Column(
          children: [
            const SizedBox(height: 20),
            Text(
              'Monthly Expense Details',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 250,
              child: BarGraph(
                bars: bars,
                maxY: maxY == 0 ? 100 : maxY * 1.2,
                labels: const ['J', 'F', 'M', 'A', 'M', 'J', 'J', 'A', 'S', 'O', 'N', 'D'],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Yearly Total: ₹ ${bars.fold(0.0, (s, b) => s + b.y).toStringAsFixed(0)}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        );
      },
    );
  }
}
