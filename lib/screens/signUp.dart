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
            RaisedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/emailLink');
              },
            ),
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
              onPressed: () async {
                //var user = await auth.edubslogin(email);
                print(email);
                await auth.sendemail(email);

                //await auth.edubslogin(email);
                /*if (user != null) {
                  Navigator.pushReplacementNamed(context, '/verification');
                } else {
                  //verificationscreen TODO
                } */
              },
            ),
          ],
        ),
      ),
    );
  }
}
