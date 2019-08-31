import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



Future<void> neverSatisfied(context) async {
  return showCupertinoDialog<void>(
    context: context,
    
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text('Rewind and remember'),
        
        actions: <Widget>[
          FlatButton(
            child: Text('Regret'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
