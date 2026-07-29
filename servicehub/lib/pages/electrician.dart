import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicehub/providers/uicreationprovider.dart';

/*change the database structure to a new one
    1.add the working models like pluming ,electrician , housecleaing , and so on 
    2.include all the workers as like random and get the user current location from the user itself .
    3.based on the locations given fetch the answers.
    4.the above tasks are optional to do .
*/
class ElectricianPage extends StatefulWidget {
  const ElectricianPage({super.key});

  @override
  State<ElectricianPage> createState() => _ElectricianPageState();
}

class _ElectricianPageState extends State<ElectricianPage> {
  @override
  Widget build(BuildContext context) {
    final uiprovider = Provider.of<UIcreationProvider>(context);
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('workers')
          .doc('Electrician')
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
                'Electrician',
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
              final data = snapshot.data!.docs[index];
              return uiprovider.createWidget(
                context,
                'Electrician',
                data['name'],
                data['location'],
                (data['phno']),
                (data['rating']),
                data['available'],
                data.id,
                data['amount'],
              );
            },
          ),
        );
      },
    );
  }
}
