import 'package:Classmate/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AufgabenService<T> {
  //Stream
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
                (doc) => Aufgabe.fromJSON(doc.id, doc.data()),
              )
              .toList(),
        );
  }

  //Set
  Future<void> setAufgabe(Aufgabe aufgabe) async {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    final FirebaseAuth auth = FirebaseAuth.instance;
    return _db.collection('Aufgaben').doc().set(
      {
        'titel': aufgabe.titel,
        'fachName': aufgabe.fachName,
        'fachFarbe': aufgabe.fachFarbe,
        'fachIcon': aufgabe.fachIcon,
        'fachID': aufgabe.fachID,
        'datum': aufgabe.datum,
        'users': [auth.currentUser.uid],
        'notiz': aufgabe.notiz,
      },
    );
  }

  //Set
  Future<void> updateAufgabe(Aufgabe aufgabe) async {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    final FirebaseAuth auth = FirebaseAuth.instance;
    return _db.collection('Aufgaben').doc(aufgabe.docRef).update(
      {
        'titel': aufgabe.titel,
        'fachName': aufgabe.fachName,
        'fachFarbe': aufgabe.fachFarbe,
        'fachIcon': aufgabe.fachIcon,
        'fachID': aufgabe.fachID,
        'datum': aufgabe.datum,
        'users': [auth.currentUser.uid],
        'notiz': aufgabe.notiz,
      },
    );
  }

  //Delete
  Future<void> deleteAufgabe(type) async {
    final FirebaseFirestore _db = FirebaseFirestore.instance;

    return _db.collection('Aufgaben').doc(type.docRef).delete();
  }
}
