import 'package:Classmate/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FaecherService<T> {
  Stream<List<Fach>> streamFach() {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    final FirebaseAuth auth = FirebaseAuth.instance;

    //TODO: Wechsle auf nur Fächer (Klassen eliminieren)
    return _db
        .collection('Klassen')
        .doc('Ih8mOpKpcCm9ftM5zlqW')
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

/*

    return _db
        .collection('Klassen')
        .doc('Ih8mOpKpcCm9ftM5zlqW')
        .collection('Faecher')
        .where('users', arrayContains: 'auth.currentUser.uid')
        .snapshots()
        .asyncExpand(
      (docSnap) {
        docSnap.docs.asMap().forEach((key, data) {
          print(data);
          AlleFaecher.fromMap(
            (data.data()),
          );
        });
      },
    );
  }
}
=========



 (docSnap) {
        docSnap.docs.asMap().forEach(
              (key, data) => AlleFaecher.fromMap(
                (data.data()),
              ),
            );
      },
      ========================

 

            =========
            
 return _db.collection('Klassen').doc(auth.currentUser.uid).snapshots().map(
          (snap) => AlleFaecher.fromMap((snap.data())),
        );

===============================================================================

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
