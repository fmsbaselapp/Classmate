import 'package:Classmate/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AufgabenService<T> {
  Stream<List<Aufgabe>> streamAufgabe() {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    final FirebaseAuth auth = FirebaseAuth.instance;

    return _db
        .collection('Aufgaben')
        .where('users', arrayContains: auth.currentUser.uid)
        .snapshots()
        .map(
          (list) => list.docs
              .map(
                (doc) => Aufgabe.fromMap(
                  (doc.data()),
                ),
              )
              .toList(),
        );
  }
}
