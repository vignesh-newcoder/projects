import 'package:flutter/material.dart';
import 'package:ArtSpark/home_page.dart';
import 'package:provider/provider.dart';
import 'level_notifier.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => LevelNotifier(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: HomePage(),
    );
  }
}
