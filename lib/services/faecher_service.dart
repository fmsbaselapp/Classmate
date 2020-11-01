import 'package:Classmate/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FaecherService<T> {
  Stream<AlleFaecher> streamFach() {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    final FirebaseAuth auth = FirebaseAuth.instance;

    return _db.collection('Nutzer').doc(auth.currentUser.uid).snapshots().map(
          (snap) => AlleFaecher.fromMap((snap.data())),
        );
  }
}

/*
auth.currentUser.uid
 .collection('Faecher')
        .doc('EgQbk1PEcxWkBxnqAw8l')
*/

/*
class FaecherService<T> {
  Stream<Fach> streamFach() {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    final FirebaseAuth auth = FirebaseAuth.instance;

    return _db.collection('Nutzer').doc('auth.currentUser.uid').snapshots().map(
          (snap) => Fach.fromMap((snap.data())),
        );
  }
}
*/
