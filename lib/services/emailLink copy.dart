import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class EmailLinkSignInSection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => EmailLinkSignInSectionState();
}

class EmailLinkSignInSectionState extends State<EmailLinkSignInSection>
    with WidgetsBindingObserver {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  AuthService auth = AuthService();

  bool _success;
  String _userEmail;
  String _userID;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    auth.getUser.then(
      (user) {
        if (user != null) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      },
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      final Uri link = await _retrieveDynamicLink();

      if (link != null) {
        final FirebaseUser user = await _auth.signInWithEmailAndLink(
          email: _userEmail,
          link: link.toString(),
        );

        if (user != null) {
          _userID = user.uid;
          auth.updateUserData(user);
           Navigator.pushReplacementNamed(context, '/home');
          _success = true;
        } else {
          print('link leer');
          _success = false;
        }
      } else {
        print('applifecicle changes');
        _success = false;
      }

      setState(() {});
    }
  }

  Future<Uri> _retrieveDynamicLink() async {
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();

    return data?.link;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: const Text('Test sign in with email and link'),
              padding: const EdgeInsets.all(16),
              alignment: Alignment.center,
            ),
           
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Please enter your email.';
                }
                return null;
              },
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              alignment: Alignment.center,
              child: RaisedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    _signInWithEmailAndLink();
                  }
                },
                child: const Text('Submit'),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                _success == null
                    ? ''
                    : (_success
                        ?  'success'
                        : 'Sign in failed'),
                style: TextStyle(color: Colors.green),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _signInWithEmailAndLink() async {
    _userEmail = _emailController.text;
   
    return await _auth.sendSignInWithEmailLink(
      email: _userEmail,
      url: 'https://appclassmate.page.link/verification',
      handleCodeInApp: true,
      iOSBundleID: 'ch.classmate.app',
      androidPackageName: 'ch.classmate.app',
      androidInstallIfNotAvailable: true,
      androidMinimumVersion: "1",
    );
    
  }
}
