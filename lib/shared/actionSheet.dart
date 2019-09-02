import 'package:Classmate/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> emailAction(context, userEmail) async {
  AuthService auth = AuthService();
  return showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) {
      return CupertinoActionSheet(
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: Text('Email bearbeiten'),
            onPressed: () {
              int _count = 0;
              Navigator.of(context).popUntil((_) => _count++ >= 2);
            },
          ),
          CupertinoActionSheetAction(
            child: Text('Email erneut senden'),
            onPressed: () {
              auth.signInWithEmailAndLink(userEmail);
              Navigator.pop(context, 'Email erneut senden');
              //TODO Feedback
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text('Abbrechen'),
          onPressed: () => Navigator.pop(context, 'Abbrechen'),
        ),
      );
    },
  );
}
