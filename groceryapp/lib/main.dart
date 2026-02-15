import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:groceryapp/firebasepages/firebase_options.dart';
import 'package:groceryapp/pages/initial.dart';
import 'package:groceryapp/pages/intropage.dart';
import 'package:groceryapp/providers/providerofitems.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final bool introSeen = prefs.getBool("intro_seen") ?? false;

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => GlobalProvider()),
    ],
    child: MyApp(introSeen: introSeen),
  ));
}

class MyApp extends StatelessWidget {
  final bool introSeen;

  const MyApp({super.key, required this.introSeen});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: introSeen ? const Initialpage() : const IntroScreen(),
    );
  }
}
