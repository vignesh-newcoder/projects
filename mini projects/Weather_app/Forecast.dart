import 'package:flutter/material.dart';

class Forecast extends StatelessWidget {
  final IconData icon;
  final String time;
  final String value;
  final String date;
  final String day;
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
    return Row(
      children: [
        Card(
          elevation: 20,
          child: Container(
            width: 250,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  time,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8),
                Icon(icon, size: 32),
                SizedBox(height: 8),
                Text(value),
              ],
            ),
          ),
        ),
        Card(
          elevation: 20,
          child: Container(
            width: 100,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [Text(date), Text(day), SizedBox(height: 8)],
            ),
          ),
        ),
      ],
    );
  }
}
