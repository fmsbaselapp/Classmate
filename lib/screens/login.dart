import 'package:Classmate/services/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Classmate/shared/button.dart';
import 'package:Classmate/services/auth.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

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
    _sentEmail = true;
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
  bool _sentEmail = true;
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
      backgroundColor: Theme.of(context).primaryColorDark,
      body: WillPopScope(
        onWillPop: () async {
          return Future.value(false);
        },
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Text(
                      'Anmelden',
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 10, left: 10, right: 10, bottom: 10),
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
                            autocorrect: false,
                            cursorColor: Theme.of(context).accentColor,
                            cursorWidth: 2,
                            expands: false,
                            enableInteractiveSelection: true,
                            decoration: InputDecoration(
                              labelText: 'Edubs Email',
                              hintText: 'vorname.nachname@stud.edubs.ch',
                              labelStyle: TextStyle(color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            onFieldSubmitted: (_) async {
                              if (_formKey.currentState.validate()) {
                                userEmail = _emailController.text;
                                final personalData =
                                    await Name().nameAusEmail(userEmail);
                                await auth
                                    .signInWithEmailAndLink(userEmail)
                                    .catchError(
                                        (onError) => _sentEmail = false);
                              } //Todo else fail},
                            },
                            validator: (String value) {
                              if (RegExp(
                                      "^([0-9]?)+([a-zA-Z]{2,15})+([0-9]?)+\.+([0-9]?)+([a-zA-Z]{2,20})+([0-9]?)+@(stud\.edubs\.ch)\$")
                                  .hasMatch(value)) {
                              } else if (value.isEmpty) {
                                return 'Bitte gib deine stud.edubs Email-Adresse ein.';
                              } else if (RegExp("^(daniel.roth@edubs.ch)")
                                  .hasMatch(value)) {
                              } else if (RegExp("^(daniela.truetsch@edubs.ch)")
                                  .hasMatch(value)) {
                              } else if (RegExp(
                                      "^(testuserclassmate@gmail.com)")
                                  .hasMatch(value)) {
                              } else if (RegExp("^([a-zA-Z.])+@(edubs\.ch)\$")
                                  .hasMatch(value)) {
                                return 'Lehrpersonen können sich leider nicht anmelden.';
                              } else {
                                return 'Bitte verwende deine stud.edubs Email-Adresse.\n';
                              }
                            },
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          alignment: Alignment.center,
                          child: SmallButton(
                            child: const Text('Weiter'),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                userEmail = _emailController.text;
                                final personalData =
                                    await Name().nameAusEmail(userEmail);

                                if (await auth
                                    .signInWithEmailAndLink(userEmail)) {
                                  print('duregloh');
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => VerifizierenScreen(
                                        userEmail: userEmail,
                                        personalData: personalData,
                                      ),
                                    ),
                                  );
                                } else {
                                  print('EMAIL SENDEN ERROR');
                                  return showPlatformDialog(
                                    context: context,
                                    builder: (_) => PlatformAlertDialog(
                                      title:
                                          Text('Ein Fehler ist aufgetreten.'),
                                      content: Text(
                                          '\nDeine Email konnte nicht versendet werden.\n \nÜberprüfe deine Internetverbindung und E-Mail-Adresse.'),
                                      actions: <Widget>[
                                        PlatformDialogAction(
                                          child: PlatformText('Okay!'),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              }
                            },
                          ),
                        ),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: TextStyle(height: 1.2),
                            children: [
                              TextSpan(
                                text:
                                    'Durch die Anmeldung stimmst du\nunseren ',
                                style: Theme.of(context)
                                    .textTheme
                                    .subhead
                                    .copyWith(color: Colors.grey, fontSize: 13),
                              ),
                              TextSpan(
                                text: 'Nutzungsbedingungen',
                                style: Theme.of(context)
                                    .textTheme
                                    .subhead
                                    .copyWith(
                                        color: Colors.grey,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    launch(
                                        'https://classmateapp.ch/nutzungsbedingungen/');
                                  },
                              ),
                              TextSpan(
                                text: '\nund ',
                                style: Theme.of(context)
                                    .textTheme
                                    .subhead
                                    .copyWith(color: Colors.grey, fontSize: 13),
                              ),
                              TextSpan(
                                text: 'Datenrichtlinien',
                                style: Theme.of(context)
                                    .textTheme
                                    .subhead
                                    .copyWith(
                                        color: Colors.grey,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    launch(
                                        'https://classmateapp.ch/datenschutz/');
                                  },
                              ),
                              TextSpan(
                                text: ' zu.',
                                style: Theme.of(context)
                                    .textTheme
                                    .subhead
                                    .copyWith(color: Colors.grey, fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(bottom: 20),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(height: 1.2),
                    children: [
                      TextSpan(
                        text: 'Probleme bei der Anmeldung? ',
                        style: Theme.of(context)
                            .textTheme
                            .subhead
                            .copyWith(color: Colors.grey, fontSize: 13),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launch('https://classmateapp.ch/hilfe/');
                          },
                      ),
                      TextSpan(
                        text: 'Hilfe ->',
                        style: Theme.of(context).textTheme.subhead.copyWith(
                            color: Colors.grey,
                            fontSize: 13,
                            fontWeight: FontWeight.w700),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launch('https://classmateapp.ch/hilfe/');
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
