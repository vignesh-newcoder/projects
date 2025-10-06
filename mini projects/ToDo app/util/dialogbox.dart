// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:taskmate/util/buttons.dart';

class Dialogbox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback oncancel;
  Dialogbox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.oncancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromARGB(255, 164, 134, 234),
      content: SizedBox(
        height: 180,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              autocorrect: true,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                hintText: 'Enter Task Name',
                hoverColor: Colors.black,
                enabled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 164, 134, 234),
                    width: 3.0,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(
                  name: 'Save',
                  onPressed: () {
                    onSave();
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                MyButton(
                  name: "Cancel",
                  onPressed: () {
                    oncancel();
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
