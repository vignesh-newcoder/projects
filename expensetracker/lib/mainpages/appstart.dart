import 'package:expensetracker/mainpages/firstScreen.dart';
import 'package:expensetracker/mainpages/intropage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStart extends StatelessWidget {
  const AppStart({super.key});

  Future<bool> isFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isFirstTime') ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isFirstLaunch(),
      builder: (context, snapshot) {
        // 🔹 Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // 🔹 Error safety
        if (snapshot.hasError) {
          return const Scaffold(
            body: Center(child: Text("Something went wrong")),
          );
        }

        // 🔹 Decision
        return snapshot.data! ? const IntroPage() : const HomePage();
      },
    );
  }
}

