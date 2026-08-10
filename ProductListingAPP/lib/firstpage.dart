
import 'package:bloc_workout/pages/cartpage.dart';
import 'package:bloc_workout/pages/homepage.dart';
import 'package:bloc_workout/pages/likedpage.dart';
import 'package:flutter/material.dart';

class Firstpage extends StatefulWidget {
  const Firstpage({super.key});

  @override
  State<Firstpage> createState() => _FirstpageState();
}

class _FirstpageState extends State<Firstpage> {
  int currIndex = 0;
  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      activeIcon: Icon(Icons.home_outlined),
      backgroundColor: Colors.blue,
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart),
      activeIcon: Icon(Icons.shopping_cart_outlined),
      backgroundColor: Colors.blue,
      label: 'Cart',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      activeIcon: Icon(Icons.favorite_border),
      backgroundColor: Colors.blue,
      label: 'Favourite',
    ),
  ];
  List<Widget> wid = [
    HomePage(),
    CartPage(),
    LikedPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: items,
        currentIndex: currIndex,
        onTap: (value) {
          setState(() {
            currIndex = value;
          });
        },
      ),
      body: wid[currIndex],
    );
  }
}
