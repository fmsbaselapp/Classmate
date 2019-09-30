import 'package:Classmate/screens/screens.dart';
import 'package:Classmate/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class LandingScreen extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of<FirebaseUser>(context);

    if (user != null) {
      return HomeScreenChecker();
    } else {
      return WelcomeScreen();
    }
  }
}
