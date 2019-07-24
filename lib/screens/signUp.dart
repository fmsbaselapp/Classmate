import 'package:flutter/material.dart';
import '../services/services.dart';

class SignUpEmail extends StatefulWidget {
  createState() => SignUpEmailState();
}

class SignUpEmailState extends State<SignUpEmail> {
  AuthService auth = AuthService();
  String email;

  @override
  void initState() {
    super.initState();
    auth.getUser.then(
      (user) {
        if (user != null) {
          // Navigator.pushReplacementNamed(context, '/topics');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextFormField(
              validator: (input) {
                if (input.isEmpty) {
                  return 'Please type an Email';
                }
                return null;
              },
              //TODO onchanged?
              onChanged: (input) => email = input,
              decoration: InputDecoration(labelText: 'Edubs Email'),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => _SignUpPassword(email: email),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SignUpPassword extends StatefulWidget {
  final String email;

  _SignUpPassword({Key key, @required this.email}) : super(key: key);

  @override
  __SignUpPasswordState createState() => __SignUpPasswordState();
}

class __SignUpPasswordState extends State<_SignUpPassword> {
  AuthService auth = AuthService();

  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Center(
              child: TextFormField(
                validator: (input) {
                  if (input.length < 6) {
                    return 'Your Password is too short';
                  }
                  return null;
                },
                onChanged: (input) => password = input,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
            ),
            RaisedButton(
              onPressed: () async {
                var user = await auth.edubslogin(widget.email, password);

                if (user != null /* TODO && verification true*/) {
                  Navigator.pushReplacementNamed(context, '/verification');
                }
                else if(user != null){
                //verificationscreen TODO
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
