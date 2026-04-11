import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:groceryapp/orderpages/ordereditems.dart';
import 'package:groceryapp/orderpages/orderitems.dart';
import 'package:groceryapp/orderpages/pages/homescreen.dart';

class Initialpage extends StatefulWidget {
  const Initialpage({super.key});

  @override
  State<Initialpage> createState() => _HomePageState();
}

class _HomePageState extends State<Initialpage> {
  int _index = 1;
  final items = <Widget>[
    Icon(Icons.store, size: 30),
    Icon(Icons.home, size: 30),
    Icon(Icons.list, size: 30),
  ];
  final List<Widget> pages = [
    Orderitems(),
    HomePage(),
    OrderedItems(),
  ];
  final List<Color> colors = [
    Colors.green,
    Colors.blue,
    Colors.red,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_index],
      bottomNavigationBar: CurvedNavigationBar(
        animationCurve: Curves.ease,
        backgroundColor: colors[_index],
        index: _index,
        items: items,
        onTap: (value) {
          setState(() {
            _index = value;
          });
        },
      ),
    );
  }
}
