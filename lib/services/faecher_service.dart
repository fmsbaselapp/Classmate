import 'package:Classmate/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FaecherService<T> {
  Stream<List<Fach>> streamFach() {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    final FirebaseAuth auth = FirebaseAuth.instance;

    //TODO: Wechsle auf nur Fächer (Klassen eliminieren)
    return _db
        .collection('Faecher')
        .where('users', arrayContains: auth.currentUser.uid)
        .snapshots()
        .map(
          (list) => list.docs
              .map(
                (doc) => Fach.fromMap(
                  (doc.data()),
                ),
              )
              .toList(),
        );
  }
}
