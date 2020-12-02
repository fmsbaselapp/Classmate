import 'package:Classmate/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InfosService<T> {
  Stream<List<Info>> streamInfos() {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    final FirebaseAuth auth = FirebaseAuth.instance;
    return _db
        .collection('Infos')
        .where('users', arrayContains: auth.currentUser.uid)
        .snapshots()
        .map(
          (list) => list.docs
              .map(
                (doc) => Info.fromJSON(doc.id, doc.data()),
              )
              .toList(),
        );
  }

  //Set
  Future<void> setInfo(Info info) async {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    final FirebaseAuth auth = FirebaseAuth.instance;
    return _db.collection('Infos').doc().set(
      {
        'titel': info.titel,
        'fachName': info.fachName,
        'fachFarbe': info.fachFarbe,
        'fachIcon': info.fachIcon,
        'fachID': info.fachID,
        'datum': info.datum,
        'users': [auth.currentUser.uid],
      },
    );
  }

  //Delete
  Future<void> deleteAufgabe(type) async {
    final FirebaseFirestore _db = FirebaseFirestore.instance;

    return _db.collection('Infos').doc(type.docRef).delete();
  }
}
