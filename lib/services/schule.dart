import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';

import 'package:provider/provider.dart';

class SchuleService {
  Future<String> get getSchule => schule();

  Future<void> schule() {
    Widget build(BuildContext context) {
      FirebaseUser user = Provider.of<FirebaseUser>(context);

      Firestore.instance
          .collection('Nutzer')
          .document(user.uid)
          .get()
          .then((asyncSnapshot) {
        if (asyncSnapshot.exists) {
          return asyncSnapshot.data['Schule'].toString();
        } else {
          print('nicht angemeldet');
          Navigator.pushReplacementNamed(context, '/login');
        }
      });
    }
  }
  // (DocumentSnapshot) => print(DocumentSnapshot.data['Schule'].toString()));
}
