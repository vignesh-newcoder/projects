import 'package:bloc_workout/firstpage.dart';
import 'package:bloc_workout/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Myprovider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Firstpage(),
      ),
    );
  }
}
