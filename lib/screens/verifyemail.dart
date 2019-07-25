import 'package:Classmate/services/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VerificationScreen extends StatefulWidget {
  VerificationScreen({Key key, FirebaseUser user}) : super(key: key);

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Text('Verification'),
                RaisedButton(
                  color: Colors.white,
                  onPressed: () {
                    auth.signOut();
                    Navigator.pushReplacementNamed(context, '/');
                  },
                ),
                RaisedButton(
                  color: Colors.red,
                  onPressed: () {
                  
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


