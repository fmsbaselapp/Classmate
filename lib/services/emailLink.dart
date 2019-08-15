import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/widgets.dart';
import 'auth.dart';
import 'package:flutter/material.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class EmailLinkSignInSection with WidgetsBindingObserver {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;

  Future<FirebaseUser> get getUser => _auth.currentUser();

  Stream<FirebaseUser> get user => _auth.onAuthStateChanged;

  bool _success;
  String _userEmail;
  String _userID;



  Future<void> signInWithEmailAndLink(_userEmail) async {
    _userEmail = _userEmail;
    print(_userEmail);
    return await _auth.sendSignInWithEmailLink(
      email: _userEmail,
      url: 'https://appclassmate.page.link/verification',
      handleCodeInApp: true,
      iOSBundleID: 'ch.classmate.app',
      androidPackageName: 'ch.classmate.app',
      androidInstallIfNotAvailable: true,
      androidMinimumVersion: "1",
    );
  }

test(){
  Future<Uri> _retrieveDynamicLink() async {
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();

    return data?.link;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      final Uri link = await _retrieveDynamicLink();

      if (link != null) {
        print(link);
        final FirebaseUser user = await _auth.signInWithEmailAndLink(
          email: _userEmail,
          link: link.toString(),
        );

        if (user != null) {
          _userID = user.uid;
          updateUserData(user);
          _success = true;
        } else {
          print('link leer');
          _success = false;
        }
      } else //else if link != null pop up
      {
        print('applifecicle changes');
        _success = false;
      }
    }
  }

}


  Future<void> updateUserData(FirebaseUser user) {
    DocumentReference reportRef = _db.collection('Nutzer').document(user.uid);

    return reportRef.setData({'uid': user.uid, 'lastActivity': DateTime.now()},
        merge: true);
  }

  Future<void> signOut() {
    return _auth.signOut();
  }
}
