import 'package:flutter/material.dart';

class Forecast extends StatelessWidget {
  final IconData icon;
  final String time;
  final double value;
  final String date;
  final String day;
  String celcius(double k) {
    double celcius = k - 273.15;
    return '${celcius.toStringAsFixed(0)}° C';
  }
  const Forecast({
    super.key,
    required this.time,
    required this.value,
    required this.icon,
    required this.date,
    required this.day,
  });
  @override
  Widget build(BuildContext context) {
    final screen1 = MediaQuery.of(context).size.width;

    final iconSize = screen1 * 0.08;
    final padding = screen1 * 0.03;
    final spacing = screen1 * 0.01;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Card(
            elevation: 20,
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    time,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: spacing),
                  Icon(icon, size: iconSize),
                  SizedBox(height: spacing),
                  Text(celcius(value), style: TextStyle(fontSize: 15)),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: padding),
        Expanded(
          child: Card(
            elevation: 20,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.all(padding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(date),
                  Text(day),
                  SizedBox(height: 8),
                  SizedBox(height: screen1 * 0.01),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}


