import 'package:flutter/material.dart';
import '../services/services.dart';
import '../shared/shared.dart';


class HomeScreen extends StatelessWidget {
  AuthService auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Text("angemeldet"),
          RaisedButton(
            onPressed: () {
              auth.signOut();
              Navigator.pushReplacementNamed(context, '/');
            },
          )
        ],
      ),
      bottomNavigationBar: AppBottomNav(),
    );
  }
}
