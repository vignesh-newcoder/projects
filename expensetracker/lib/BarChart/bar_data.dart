import 'package:expensetracker/BarChart/individualbar.dart';

class BarData {
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thursAmount;
  final double friAmount;
  final double satAmount;

  BarData({
    required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thursAmount,
    required this.friAmount,
    required this.satAmount,
  });

  List<Individualbar> barData = [];

  void initialziedBar() {
    barData = [
      Individualbar(x: 0, y: sunAmount),
      Individualbar(x: 1, y: monAmount),
      Individualbar(x: 2, y: tueAmount),
      Individualbar(x: 3, y: wedAmount),
      Individualbar(x: 4, y: thursAmount),
      Individualbar(x: 5, y: friAmount),
      Individualbar(x: 6, y: satAmount),
    ];
  }
}
