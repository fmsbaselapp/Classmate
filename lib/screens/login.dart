
import 'package:Classmate/services/emailLink.dart';
import 'package:Classmate/services/auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _userEmail = TextEditingController();
  AuthService auth = AuthService();
  
  @override
  void dispose() {
    // Clean up the email Controller  when the widget is disposed.
    _userEmail.dispose();
    super.dispose();}


  bool _emailGesendet;



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
              controller: _userEmail,
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
                    try {
                      EmailLinkSignInSection().signInWithEmailAndLink(_userEmail.text);
                      try {
                        await EmailLinkSignInSection().test();
                      } catch (e) {
                      }
                    } catch (e) {
                      print(e);
                    } 
                    
                  }
                },
                child: const Text('Submit'),
              ),
            )
          ]
        )
      )
    );
  }
}