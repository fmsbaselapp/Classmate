import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


import 'package:provider/provider.dart';

class SchuleService extends StatelessWidget {
  String schule;
  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    return StreamBuilder(
      stream: Firestore.instance
          .collection('Nutzer')
          .document(user.uid)
          .snapshots(),
      builder: (context, snapshot) {
        //check if snapshot has data
        if (!snapshot.hasData) {
          return Text("Lädt..",
              style: Theme.of(context).textTheme.title); //TODO loading

          //if snapshot has data:
        } else {
          print('Schule');
          String schule = snapshot.data['Schule'];
          return null;
        }
      },
    );
    
  }

}
