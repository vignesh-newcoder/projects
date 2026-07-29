import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:servicehub/providers/workerssection.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> currentFields = [];

  List<Map<String, dynamic>> history = [];

  Map<String, WorkerSection> sessions = {};

  Map<String, dynamic>? users;

  Future<void> getData() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final snapshots = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('PastDataSet')
        .get();

    history = snapshots.docs.map((doc) {
      return {
        'id': doc.id,
        ...doc.data(),
      };
    }).toList();

    notifyListeners();
  }

  Future<void> deleteData(int index) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('PastDataSet')
        .doc(history[index]['id'])
        .delete();

    history.removeAt(index);
    notifyListeners();
  }

  void addField(Map<String, dynamic> data) {
    currentFields.add(data);
    notifyListeners();
  }

  void removeField(Map<String, dynamic> data) {
    currentFields.remove(data);
    notifyListeners();
  }

  Future<void> getUsers() async {
    final currentuser = FirebaseAuth.instance.currentUser;

    if (currentuser == null) {
      return;
    }
    final user = await FirebaseFirestore.instance.collection('users').doc(currentuser.uid).get();
    users = user.data();
    notifyListeners();
  }
}
