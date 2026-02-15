import 'package:expensetracker/expense/expense.dart';
import 'package:expensetracker/mainpages/appstart.dart';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('Myexpensedb');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Expense(),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home:AppStart(),
        themeAnimationCurve: Curves.bounceIn,
        darkTheme: ThemeData.dark(),
      ),
    );
  }
}
