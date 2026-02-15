import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExpenseTile extends StatelessWidget {
  final String name;
  final String amount;
  final DateTime dateTime;
  void Function(BuildContext)? deleteontapped;

  ExpenseTile({
    super.key,
    required this.name,
    required this.amount,
    required this.dateTime,
    required this.deleteontapped,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.30,
        motion: StretchMotion(),
        children: [
          CustomSlidableAction(
            onPressed: deleteontapped,
            backgroundColor: Colors.red,
            borderRadius: BorderRadius.circular(20),
            child: Center(
              child: Icon(
                Icons.delete,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: ListTile(
            title: Text(
              name[0].toUpperCase() + name.substring(1),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            subtitle: Text(
              '${dateTime.day.toString()}/${dateTime.month.toString()}/${dateTime.year.toString()}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            trailing: Text(
              '\u20B9 $amount',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
