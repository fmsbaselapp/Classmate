import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Classmate/services/auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class VerifizierenScreen extends StatefulWidget {
  final userEmail;

  VerifizierenScreen({Key key, @required this.userEmail}) : super(key: key);

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

    //TODO else
    try {
      if (link != null) {
        if (_linkvalidation) {
          print(_linkvalidation);
          print('link isch guet');
          await auth.signIn(widget.userEmail, link);
          print('successè!!!!!!!!!!!!!!');
          _success = true;
          auth.getUser.then(
            (user) {
              if (user != null) {
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
        backgroundColor: Colors.orange,
        body: Column(
          children: <Widget>[Text(widget.userEmail)],
        ),
      ),
    );
  }
}
