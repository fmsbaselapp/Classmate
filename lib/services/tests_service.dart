import 'package:Classmate/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TestsService<T> {
  Stream<List<Test>> streamTests() {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    final FirebaseAuth auth = FirebaseAuth.instance;
    return _db
        .collection('Tests')
        .where('users', arrayContains: auth.currentUser.uid)
        .snapshots()
        .map(
          (list) => list.docs
              .map(
                (doc) => Test.fromJSON(doc.id, doc.data()),
              )
              .toList(),
        );
  }

  //Set
  Future<void> setTest(Test test) async {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    final FirebaseAuth auth = FirebaseAuth.instance;
    return _db.collection('Tests').doc().set(
      {
        'titel': test.titel,
        'fachName': test.fachName,
        'fachFarbe': test.fachFarbe,
        'fachIcon': test.fachIcon,
        'fachID': test.fachID,
        'datum': test.datum,
        'notiz': test.notiz,

        //gewichtung
        'users': [auth.currentUser.uid],
      },
    );
  }

  //Update
  Future<void> updateTest(Test test) async {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    final FirebaseAuth auth = FirebaseAuth.instance;
    return _db.collection('Tests').doc(test.docRef).update(
      {
        'titel': test.titel,
        'fachName': test.fachName,
        'fachFarbe': test.fachFarbe,
        'fachIcon': test.fachIcon,
        'fachID': test.fachID,
        'datum': test.datum,
        'notiz': test.notiz,

        //gewichtung
        'users': [auth.currentUser.uid],
      },
    );
  }

  //Delete
  Future<void> deleteTest(type) async {
    final FirebaseFirestore _db = FirebaseFirestore.instance;

    return _db.collection('Tests').doc(type.docRef).delete();
  }
}
