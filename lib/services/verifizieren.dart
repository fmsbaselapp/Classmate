import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Classmate/services/auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:url_launcher/url_launcher.dart';

class VerifizierenScreen extends StatefulWidget {
  final userEmail;
  final personalData;

  VerifizierenScreen({Key key, @required this.userEmail, this.personalData})
      : super(key: key);

  _VerifizierenScreenState createState() => _VerifizierenScreenState();
}

class _VerifizierenScreenState extends State<VerifizierenScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AuthService auth = AuthService();

  //Values
  bool _success;

//Check ob Nutzer angemeldet + Dynamic Links
  @override
  void initState() {
    super.initState();
    this.initDynamicLinks();
    auth.getUser.then(
      (user) {
        if (user != null) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      },
    );
  }

  //DeepLink wenn app neu geöffnet wird
  void initDynamicLinks() async {
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;

    if (deepLink != null) {
      print(deepLink);
      print('link empfangen');
      confirmSignIn(deepLink);
      //Todo
    }

    //DeepLink wenn app schon offen ist
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      final Uri deepLink = dynamicLink?.link;

      if (deepLink != null) {
        print(deepLink);
        print('link empfangen wenn app offen');
        confirmSignIn(deepLink);
        //Todo
      }
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });
  }

  //Deeplink validation
  void confirmSignIn(deepLink) async {
    final link = await deepLink;
    final _linkvalidation = await _auth.isSignInWithEmailLink(link.toString());

    try {
      if (link != null) {
        if (_linkvalidation) {
          print(_linkvalidation);
          print('link isch guet');
          await auth.signIn(widget.userEmail, link, widget.personalData);
          print('successè!!!!!!!!!!!!!!');
          _success = true;
          auth.getUser.then(
            (user) {
              if (user != null && _success) {
                Navigator.pushReplacementNamed(context, '/home');
              }
            },
          );
          setState(() {});
        } else {
          print('link leer');
          _success = false;
        }
      } else {
        print('leer');
      }
      setState(() {});
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 50),
              child: Text(
                "Hey " + widget.personalData[0].toString() + ",",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
              child: Text(
                "Wir haben eine Email an",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline,
              ),
            ),
            Container(
              color: Colors.blue,
              alignment: Alignment.center,
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
              child: Text(
                widget.userEmail,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                "geschickt, mit der du dich anmelden kannst.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline,
              ),
            ),
            RaisedButton(
              elevation: 100,
              highlightElevation: 100,
              onPressed: _launchURL,
              child: Text(
                'Teamwork öffnen',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subhead,
              ),
            ),
            RaisedButton(
              elevation: 100,
              highlightElevation: 100,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Email bearbeiten'),
            )
          ],
        ),
      ),
    );
  }
}
_launchURL() async {
  const url = 'https://teamwork.edubs.ch/appsuite/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}