import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// ignore: must_be_immutable
class ToDoTile extends StatelessWidget {
  final String name;
  final bool flag;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteItems;
  ToDoTile({
    super.key,
    required this.name,
    required this.flag,
    required this.onChanged,
    required this.deleteItems,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(onPressed: deleteItems, icon: Icons.delete, backgroundColor: Colors.red,),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60),
            border: BoxBorder.all(
              color: const Color.fromARGB(255, 164, 134, 234),
              style: BorderStyle.solid,
            ),
            color: const Color.fromARGB(255, 164, 134, 234),
          ),
          child: Row(
            children: [
              Checkbox(
                value: flag,
                onChanged: onChanged,
                activeColor:
                    Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
              ),
              Text(
                name,
                style: TextStyle(
                  decoration: flag ? TextDecoration.lineThrough : TextDecoration.none,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
