import 'package:Classmate/shared/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Classmate/services/auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

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
      //Todo Loading spinner
    }

    //DeepLink wenn app schon offen ist
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      final Uri deepLink = dynamicLink?.link;

      if (deepLink != null) {
        print(deepLink);
        print('link empfangen wenn app offen');
        confirmSignIn(deepLink);
        //Todo Loading spinner
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
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              //hey name
              Padding(
                padding: EdgeInsets.only(top: 40),
                child: Text(
                  "Hey " + widget.personalData[0].toString(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.title,
                ),
              ),

              //text über email button
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  "Wir haben eine Email an",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline,
                ),
              ),

              //email button
              LableButton(
                onPressed: () {
                  PopupMenuButton(
                //TODO Popup
                  );
                },
                child: Text(
                  widget.userEmail,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              //text unter email
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 20),
                child: Text(
                  "gesendet, mit der du dich\nanmelden kannst.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline,
                ),
              ),

              //text über Teamwork öffnen
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Sieh in deinen Mails, oder öffne:",
                      style: Theme.of(context).textTheme.headline,
                    ),
                  ),
                ),
              ),

              //Teamwork öffnen
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: SizedBox(
                    width: double.infinity,
                    child: ButtonTheme(
                      child: LableButton(
                        color: Colors.lightBlue[800],
                        onPressed: _launchURL,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Icon(
                              OMIcons.email,
                              color: Colors.white,
                            ),
                            Text(
                              'Edubs Teamwork',
                              style: TextStyle(color: Colors.white),
                            ),
                            Icon(
                              Icons.open_in_new,
                              color: Colors.white,
                            )

                            //todo same height
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

//öffnet url im browser
  _launchURL() async {
    const url = 'https://teamwork.edubs.ch/appsuite/';
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false);
    } else {
      throw 'Teamwork konnte nicht geöffnet werden';
    }
  }
}
