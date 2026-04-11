import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:servicehub/pages/electrician.dart';
import 'package:servicehub/pages/housecleaning.dart';
import 'package:servicehub/pages/plumingpage.dart';

class Firstscreen extends StatefulWidget {
  const Firstscreen({super.key});

  @override
  State<Firstscreen> createState() => _FirstscreenState();
}

class _FirstscreenState extends State<Firstscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 30,
        title: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Text(
            'ServiceHub',
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Align(
        alignment: AlignmentGeometry.center,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              SizedBox(height: 60),
              serviec(
                context,
                Icon(
                  Icons.water_drop,
                  color: Colors.white,
                ),
                'Plumbing',
                PlumingPage(),
              ),
              SizedBox(height: 20),
              serviec(
                context,
                Icon(
                  Icons.thunderstorm_sharp,
                  color: Colors.white,
                ),
                'Electrician',
                ElectricianPage(),
              ),
              SizedBox(height: 20),
              serviec(
                context,
                Icon(
                  Iconsax.home_21,
                  color: Colors.white,
                ),
                'House Cleaning',
                HousecleaningPage(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget serviec(BuildContext context, Icon icon, String name, Widget newpage) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: List.empty(growable: false),
      borderRadius: BorderRadius.circular(20),
      border: BoxBorder.all(
        color: const Color.fromARGB(255, 153, 153, 153),
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
            child: icon,
          ),
          SizedBox(width: 10),
          Text(
            name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
            ),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => newpage)),
            child: Icon(
              Icons.arrow_forward_ios_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );
}
