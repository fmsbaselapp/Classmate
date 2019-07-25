import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;

  Future<FirebaseUser> get getUser => _auth.currentUser();

  Stream<FirebaseUser> get user => _auth.onAuthStateChanged;

  Future<FirebaseUser> edubslogin(String email) async {
    try {


      try {
        await _auth.sendSignInWithEmailLink(
          email: email,
          url: 'https://classmateapp.page.link/verification',
          handleCodeInApp: true,
          iOSBundleID: 'ch.classmate.app',
          androidPackageName: 'ch.classmate.app',
          androidInstallIfNotAvailable: false,
          androidMinimumVersion: '12',
        );
        print('gesendet!');
      } catch (error) {
        print(error);
        print('error');

        //await _auth.isSignInWithEmailLink(link);
      }
/*
      updateUserData(user);
      return user;
    } catch (error) {
      print(error);
      return null;
    }
  }*/
      /*
      FirebaseUser user =
          await _auth.signInWithEmailAndLink(email: email, link: link);
      updateUserData(user);

      return user;
      */
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<void> sendemail(String email) async {
    try {
      await _auth.sendSignInWithEmailLink(
        email: email,
        url: 'https://www.classmate.ch',
        handleCodeInApp: true,
        iOSBundleID: 'ch.classmate.app',
        androidPackageName: 'ch.classmate.app',
        androidInstallIfNotAvailable: false,
        androidMinimumVersion: '12',

      );
      print('gesendet!');
    } catch (error) {
      print(error);
      return null;
    }
  }


  //await _auth.isSignInWithEmailLink(link);

  Future<void> updateUserData(FirebaseUser user) {
    DocumentReference reportRef = _db.collection('Nutzer').document(user.uid);

    return reportRef.setData({'uid': user.uid, 'lastActivity': DateTime.now()},
        merge: true);
  }

  Future<void> signOut() {
    return _auth.signOut();
  }
}

// keytool -list -v -alias androiddebugkey -keystore %USERPROFILE%\.android\debug.keystore
