import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;

  Future<FirebaseUser> get getUser => _auth.currentUser();

  Stream<FirebaseUser> get user => _auth.onAuthStateChanged;

  Future<bool> signIn(userEmail, link, personalData) async {

    final AuthResult userResult = await _auth
        .signInWithEmailAndLink(
      email: userEmail,
      link: link.toString(),
    )
        .catchError(
      (onError) {
        print(onError);
        return false;
      },
    );

    if (user != null) {
      await updateUserData(userResult.user);
      await updateName(personalData, userResult.user);
      return true;
    } else {
      print('link leer');
      return false;
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
      'Email': personalData[2],
      
    }, merge: true);
  }

  Future<void> signOut() {
    return _auth.signOut();
  }

  //Email Link senden
  Future<bool> signInWithEmailAndLink(userEmail) async {
    print(userEmail);
    try {
      return await _auth
          .sendSignInWithEmailLink(
        email: userEmail,
        url: 'https://appclassmate.page.link/verification',
        handleCodeInApp: true,
        iOSBundleID: 'ch.classmate.app',
        androidPackageName: 'ch.classmate.app',
        androidInstallIfNotAvailable: true,
        androidMinimumVersion: "1",
      )
          .then((onValue) {
        return true;
      });
    } catch (e) {
      print(e);
      print('error AUTH');
      return false;
    }
  }
}
