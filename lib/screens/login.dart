import 'package:Classmate/services/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:Classmate/services/auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> with WidgetsBindingObserver {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  AuthService auth = AuthService();

//Check ob Nutzer angemeldet + Dynamic Links
  @override
  void initState() {
    super.initState();
    auth.getUser.then(
      (user) {
        if (user != null) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      },
    );
  }

  //Values
  bool _sentEmail = false;
  String userEmail;

  //DISPOSE FROM EmailController
  @override
  void dispose() {
    _emailController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  //Email Link senden
  Future<void> _signInWithEmailAndLink() async {
    userEmail = _emailController.text;
    print(userEmail);
    return await _auth.sendSignInWithEmailLink(
      email: userEmail,
      url: 'https://appclassmate.page.link/verification',
      handleCodeInApp: true,
      iOSBundleID: 'ch.classmate.app',
      androidPackageName: 'ch.classmate.app',
      androidInstallIfNotAvailable: true,
      androidMinimumVersion: "1",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Please enter your email.';
                }
                return null;
              },
              /*
              onChanged: (text){if (input(text)) {
                
              } else {
              }},
              */
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              alignment: Alignment.center,
              child: RaisedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    await _signInWithEmailAndLink()
                        .catchError((onError) => _sentEmail = false);
                    _sentEmail = true;

                    if (_sentEmail == true) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              VerifizierenScreen(userEmail: userEmail),
                        ),
                      );
                    }
                  } //Todo else fail
                },
                child: const Text('okay'),
              ),
            ),
          ],
        ),
      ),
    );
  }
/*
  input(text){
    bool emailValid = RegExp (/^([a-zA-Z]{2,15})+\.+([a-zA-Z]{2,15})+@(stud.edubs.ch)$/gm).hasMatch(text);
  if (emailValid) {
    
  } else {
  }

  }
  */


}
