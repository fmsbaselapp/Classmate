import 'dart:io';

import 'package:Classmate/screens/screens.dart';
import 'package:Classmate/services/services.dart';
import 'package:flutter/material.dart';

class SignOut extends StatelessWidget {
  AuthService auth = AuthService();
  @override
  Widget build(BuildContext context) {
    sleep(const Duration(seconds: 1));
    auth.signOut();

    return LoginScreen();
    
  }
}
