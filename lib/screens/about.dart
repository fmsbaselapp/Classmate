import 'package:Classmate/shared/button.dart';
import 'package:flutter/material.dart';
import 'package:Classmate/services/auth.dart';


class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthService auth = AuthService();
    return Scaffold(
      body: Column(
        children: <Widget>[
          SmallButton(
            onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
            child: Text('Home'),
          ),
          SmallButton(
            onPressed: () {
              auth.signOut();
              Navigator.pushReplacementNamed(context, '/');
            },
            child: Text('Abmelden'),
          ),
          Center(
            child: Text('About this app...'),
          ),
        ],
      ),
    );
  }
}
