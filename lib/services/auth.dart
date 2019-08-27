import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;

  Future<FirebaseUser> get getUser => _auth.currentUser();

  Stream<FirebaseUser> get user => _auth.onAuthStateChanged;

  Future<void> signIn(userEmail, link, personalData) async {
    final FirebaseUser user = await _auth
        .signInWithEmailAndLink(
          email: userEmail,
          link: link.toString(),
        )
        .catchError((onError) => print(onError));

    if (user != null) {
      await updateUserData(user);
      await updateName(personalData, user);
      return true;
    } else {
      print('link leer');
    }
  }

  Future<void> updateUserData(FirebaseUser user) {
    DocumentReference reportRef = _db.collection('Nutzer').document(user.uid);

    return reportRef.setData({'uid': user.uid, 'lastActivity': DateTime.now()},
        merge: true);
  }

  Future<void> updateName(personalData, FirebaseUser user) {
    DocumentReference reportRef = _db.collection('Nutzer').document(user.uid);

    return reportRef.setData({
      'Vorname': personalData[0],
      'Nachname': personalData[1],
      'Email': personalData[2]
    }, merge: true);
  }

  Future<void> signOut() {
    return _auth.signOut();
  }
}
