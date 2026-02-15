// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  String name;
  VoidCallback onPressed;
  MyButton({
    super.key,
    required this.name,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        onPressed();
      },
      color: const Color.fromARGB(255, 164, 134, 234),
      hoverElevation: 12,
      autofocus: true,
      child: Text(name),
    );
  }
}
