import 'dart:io';
import 'package:Classmate/screens/screens.dart';
import 'package:Classmate/shared/shared.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateScreen extends StatelessWidget {
  const UpdateScreen({Key key, @required this.user, @required this.force})
      : super(key: key);

  final FirebaseUser user;
  final bool force;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColorDark,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Eine neue Version\n von Classmate ist verfügbar.',
                    style: Theme.of(context)
                        .textTheme
                        .headline
                        .copyWith(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 100,
                      right: 100,
                      top: 20,
                    ),
                    child: LableButton(
                      onPressed: () {
                        _launchURL();
                      },
                      child: Text(
                        'Updaten',
                        style: Theme.of(context)
                            .textTheme
                            .button
                            .copyWith(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
              if (!force)
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(height: 1),
                      children: [
                        TextSpan(
                          text: 'Weiter ohne Update ->',
                          style: Theme.of(context).textTheme.headline.copyWith(
                                fontSize: 14,
                              ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CheckerModule(
                                    user: user,
                                  ),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                )
              else
                Container(),
            ],
          ),
        ),
      ),
    );
  }

  //öffnet url
  _launchURL() async {
    const Android =
        'https://play.google.com/store/apps/details?id=ch.classmate.app';
    const IOS = 'https://apps.apple.com/us/app/classmate/id1483540166?ls=1';

    if (Platform.isIOS) {
      if (await canLaunch(IOS)) {
        await launch(IOS, forceSafariVC: false);
      } else {
        throw 'Link konnte nicht geöffnet werden.';
      }
    } else if (await canLaunch(Android)) {
      await launch(Android, forceSafariVC: false);
    } else {
      throw 'Link konnte nicht geöffnet werden.';
    }
  }
}