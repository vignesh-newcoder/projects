import 'package:flutter/material.dart';
import 'package:learning/cubits/counter_cubits.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final obj = Mycubits().state;
  // int c = 0;
  // @override
  // void increment() {
  //   setState(() {
  //     c++;
  //   });
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[200],
        title: Text('This an demo flutter app'),
        centerTitle: true,
      ),
      body: Align(
        alignment: AlignmentGeometry.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('You have pushed this button for this no of times'),
            Text(
              obj.toString(),
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.pink[200],
        child: Icon(Icons.add),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }
}
