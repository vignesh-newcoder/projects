import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:servicehub/pages/firstscreen.dart';
import 'package:servicehub/pages/History/history.dart';
import 'package:servicehub/pages/profile.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  int _index = 0;
  List page = <Widget>[
    Firstscreen(),
    HistoryPage(),
    Profile(),
  ];
  List<Widget> list = [
    Icon(
      Icons.home,
      size: 30,
      color: Colors.white,
    ),
    Icon(
      Icons.history,
      size: 30,
      color: Colors.white,
    ),
    Icon(
      Icons.person,
      size: 30,
      color: Colors.white,
    )
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: page[_index],
      bottomNavigationBar: CurvedNavigationBar(
        index: _index,
        items: list,
        onTap: (value) {
          setState(
            () {
              _index = value;
            },
          );
        },
        color: Colors.black,
        backgroundColor: Colors.white,
        animationCurve: Curves.ease,
      ),
    );
  }
}
