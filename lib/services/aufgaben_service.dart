import 'package:Classmate/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AufgabenService<T> {
  Stream<AlleAufgaben> streamAufgabe() {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    final FirebaseAuth auth = FirebaseAuth.instance;

    return _db.collection('Nutzer').doc(auth.currentUser.uid).snapshots().map(
          (snap) => AlleAufgaben.fromMap((snap.data())),
        );
  }
}
