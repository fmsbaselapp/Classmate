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
                (doc) => Info.fromMap(
                  (doc.data()),
                ),
              )
              .toList(),
        );
  }
}
