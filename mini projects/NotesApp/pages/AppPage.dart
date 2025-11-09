// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/services/firestoreservices.dart';
import 'package:flutter/material.dart';

class MyApps extends StatefulWidget {
  const MyApps({super.key});

  @override
  State<MyApps> createState() => _MyAppsState();
}

class _MyAppsState extends State<MyApps> {
  TextEditingController tec = TextEditingController();
  Firestore f = Firestore();
  void openBox({String? docId}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: tec,
          decoration: InputDecoration(
            hintText: 'Enter your notes',
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (docId == null) {
                f.addNote(tec.text);
              } else {
                f.updateData(docId, tec.text);
              }
              tec.clear();
              Navigator.of(context).pop();
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notes",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openBox();
        },
        backgroundColor:
            Theme.of(context).brightness == Brightness.dark ? Colors.grey : Colors.white,
        child: Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: f.getdata(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error: ${snapshot.error}",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red),
              ),
            );
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                "No notes were added",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }
          List noteslist = snapshot.data!.docs;

          return ListView.builder(
            itemCount: noteslist.length,
            itemBuilder: (context, index) {
              DocumentSnapshot doc = noteslist[index];
              String docID = doc.id;

              Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
              String notesdata = map['note'];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    title: Text(
                      notesdata,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            openBox(docId: docID);
                          },
                          icon: Icon(
                            Icons.update,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            f.deleteData(docID);
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
