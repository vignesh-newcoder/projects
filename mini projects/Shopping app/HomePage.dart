import 'package:flutter/material.dart';
import 'package:shopping/pages/Addtocart.dart';
import 'package:shopping/pages/productList.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentpage = 0;
  List<Widget> pages = [ProductList(), Addtocart()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: currentpage, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 35,
        unselectedFontSize: 0,
        selectedFontSize: 0,
        onTap: (value) {
          setState(() {
            currentpage = value;
          });
        },
        currentIndex: currentpage,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: ''),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_checkout),
            label: '',
          ),
        ],
      ),
    );
  }
}
