import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicehub/providers/uicreationprovider.dart';

class HousecleaningPage extends StatefulWidget {
  const HousecleaningPage({super.key});

  @override
  State<HousecleaningPage> createState() => _HousecleaningPageState();
}

class _HousecleaningPageState extends State<HousecleaningPage> {
  @override
  Widget build(BuildContext context) {
    final uiprovider = Provider.of<UIcreationProvider>(context);
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('workers')
          .doc('HouseCleaning')
          .collection('workerlist')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData) {
          return Center(
            child: Text('No Workers found on your city'),
          );
        }
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 30,
            title: Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Text(
                'House Cleaning',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          body: ListView.builder(
            itemCount: snapshot.data!.size,
            itemBuilder: (BuildContext context, int index) {
              final detail = snapshot.data!.docs[index];
              return uiprovider.createWidget(
                context,
                'HouseCleaning',
                detail['name'],
                detail['location'],
                detail['phno'],
                (detail['rating']),
                detail['available'],
                detail.id,
                detail['amount'],
              );
            },
          ),
        );
      },
    );
  }
}
