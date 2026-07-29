import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicehub/providers/uicreationprovider.dart';

class PlumingPage extends StatefulWidget {
  const PlumingPage({super.key});

  @override
  State<PlumingPage> createState() => _PlumingPageState();
}

class _PlumingPageState extends State<PlumingPage> {
  @override
  Widget build(BuildContext context) {
    final uiprovider = Provider.of<UIcreationProvider>(context);

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('workers')
          .doc('Plumming')
          .collection('workerlist')
          .snapshots(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
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
                'Plumbing',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          body: ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final detail = snapshot.data!.docs[index];

              return uiprovider.createWidget(
                context,
                'Pluming',
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
