import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Firestore {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference get _notes {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('Users are not sigined');
    }
    return _firestore.collection('users').doc(user.uid).collection('notes');
  }

  Future<void> addNote(String note) {
    return _notes.add({
      'note': note,
      "timeStamp": Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> getdata() {
    final note = _notes.orderBy("timeStamp", descending: true).snapshots();
    return note;
  }

  Future<void> updateData(String docId, String newData) {
    return _notes.doc(docId).update(
      {'note': newData, 'timeStamp': Timestamp.now()},
    );
  }

  Future<void> deleteData(String docId) {
    return _notes.doc(docId).delete();
  }
}
