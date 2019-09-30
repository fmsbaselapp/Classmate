import 'package:Classmate/screens/screens.dart';
import 'package:Classmate/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LandingScreen extends StatelessWidget {
  AuthService auth = AuthService();
  @override
  Widget build(BuildContext context) {
    var user = auth.getUser;

    if (user != null) {
      return HomeScreenChecker();
    } else {
      return LoginScreen();
    }
  }
}
