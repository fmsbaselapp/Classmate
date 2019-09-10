import 'package:Classmate/services/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Classmate/shared/button.dart';
import 'package:Classmate/services/auth.dart';



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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          Future.value(false);
        },
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 40),
              child: Text(
                'Anmelden',
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 10, right: 10),
              child: Text(
                'Melde dich mit deiner\nEdubs Email Adresse an.',
                style: Theme.of(context).textTheme.headline,
                textAlign: TextAlign.center,
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.send,
                        onFieldSubmitted: (_) async {
                          if (_formKey.currentState.validate()) {
                            userEmail = _emailController.text;
                            final personalData =
                                await Name().nameAusEmail(userEmail);
                            await auth.signInWithEmailAndLink(userEmail)
                                .catchError((onError) => _sentEmail = false);
                            _sentEmail = true;

                            if (_sentEmail == true) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => VerifizierenScreen(
                                    userEmail: userEmail,
                                    personalData: personalData,
                                  ),
                                ),
                              );
                            }
                          } //Todo else fail},
                        },
                      
                        autocorrect: false,
                        cursorColor: Colors.red,
                       cursorWidth: 2,
                    expands: false,
                    enableInteractiveSelection: true,
                    
                        decoration: InputDecoration(
                          labelText: 'Edubs Email',
                          hintText: 'vorname.nachname@stud.edubs.ch',
                        ),
                        validator: (String value) {
                          if (RegExp(
                                  "^([a-zA-Z]{2,15})+\.+([a-zA-Z]{2,15})+@(stud\.edubs\.ch)\$")
                              .hasMatch(value)) {
                            return null;
                          } else if (value.isEmpty) {
                            return 'Bitte gib deine Edubs Email Adresse ein.';
                          } else if (RegExp("^([a-zA-Z.])+@(edubs\.ch)\$")
                              .hasMatch(value)) {
                            return 'Lehrpersonen können sich leider nicht anmelden.';
                          } else {
                            return 'Bitte verwende deine Edubs Email Adresse.';
                          }
                        }),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    alignment: Alignment.center,
                    child: SmallButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          userEmail = _emailController.text;
                          final personalData =
                              await Name().nameAusEmail(userEmail);
                          await auth.signInWithEmailAndLink(userEmail)
                              .catchError((onError) => _sentEmail = false);
                          _sentEmail = true;

                          if (_sentEmail == true) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => VerifizierenScreen(
                                  userEmail: userEmail,
                                  personalData: personalData,
                                ),
                              ),
                            );
                          }
                        } //Todo else fail
                      },
                      child: const Text('Weiter'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
