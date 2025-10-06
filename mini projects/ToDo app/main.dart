import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taskmate/homepage.dart';

void main() async {
  await Hive.initFlutter();

  var box = await Hive.openBox("mybox");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeAnimationCurve: Curves.bounceIn,
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      themeMode: ThemeMode.system,
      home: HomePage(),
      title: 'TODO APP',
      debugShowCheckedModeBanner: false,
    );
  }
}
