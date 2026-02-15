import 'package:expensetracker/BarChart/bar_graph.dart';
import 'package:expensetracker/expense/expense.dart';
import 'package:expensetracker/BarChart/individualbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Expensesummmary extends StatelessWidget {
  final DateTime startOfWeek;

  const Expensesummmary({super.key, required this.startOfWeek});

  @override
  Widget build(BuildContext context) {
    return Consumer<Expense>(
      builder: (context, expense, child) {
        final weeklyData =
            expense.calculateWeeklyExpenses(startOfWeek);

        final labels = const ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

        final bars = List.generate(7, (index) {
          final dateKey = expense.convertDateTime(
            startOfWeek.add(Duration(days: index)),
          );
          return Individualbar(
            x: index,
            y: weeklyData[dateKey] ?? 0,
          );
        });

        final maxY = bars
            .map((b) => b.y)
            .reduce((a, b) => a > b ? a : b);

        return SizedBox(
          height: 200,
          child: BarGraph(
            bars: bars,
            maxY: maxY == 0 ? 100 : maxY * 1.2,
            labels: labels,
          ),
        );
      },
    );
  }
}

