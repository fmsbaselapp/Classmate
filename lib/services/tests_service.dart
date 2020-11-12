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
                (doc) => Test.fromMap(
                  (doc.data()),
                ),
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

        //gewichtung
        'users': [auth.currentUser.uid],
      },
    );
  }
}
