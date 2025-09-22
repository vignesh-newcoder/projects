import 'package:flutter/material.dart';

class Content extends StatefulWidget {
  const Content({super.key});

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Unit Convertor',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: Column(
        children: [
          unitConvertors(
            'Area Conversions',
            Icon(Icons.square_foot),
            Color.fromRGBO(5, 79, 237, 1),
          ),
          unitConvertors(
            'Weight Conversion',
            Icon(Icons.fitness_center_outlined),
            Color.fromRGBO(0, 0, 0, 1),
          ),
          unitConvertors(
            'Temperature',
            Icon(Icons.thermostat),
            Color.fromRGBO(239, 6, 6, 1),
          ),
          unitConvertors(
            'Volume',
            Icon(Icons.square),
            Color.fromRGBO(175, 174, 158, 1),
          ),
          unitConvertors(
            'Energy',
            Icon(Icons.bolt),
            Color.fromRGBO(244, 201, 11, 1),
          ),
        ],
      ),
    );
  }

  Widget unitConvertors(String name, Icon icon, Color color) {
    return Container(
      height: MediaQuery.of(context).size.height / 8,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromRGBO(47, 47, 47, 1),
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: icon,
                      color: color,
                      iconSize: 60,
                    ),
                    GestureDetector(child: Icon(Icons.arrow_forward_ios)),
                  ],
                ),
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
