import 'package:Classmate/shared/button.dart';
import 'package:flutter/material.dart';
import 'package:Classmate/services/auth.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget {


  
  @override
  Widget build(BuildContext context) {
  bool toBeMergedWithAncestors = false;
  bool allowDescendantsToAddSemantics = false;

    AuthService auth = AuthService();
    return Semantics(

      container: toBeMergedWithAncestors,
    explicitChildNodes: allowDescendantsToAddSemantics,
          child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100.0),
          child: PlatformAppBar(
            backgroundColor: Colors.transparent,
            android: (_) => MaterialAppBarData(),
            ios: (_) => CupertinoNavigationBarData(),
            title: new Text(
              'Einstellungen',
              style: Theme.of(context).textTheme.title,
            ),
          ),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              LableButton(
                child: Text('Teamwork öffnen'),
                onPressed: _launchURL,
              ),
              LableButton(
                child: Text('Gratis Office, Word, Powerpoint'),
                onPressed: () {},
              ),
              LableButton(
                child: Text('Abmelden'),
                onPressed: () {
                  auth.signOut();
                  Navigator.pushReplacementNamed(context, '/');
                },
              ),
                  LableButton(
                child: Text('Nutzungsbedingungen'),
                onPressed: () {
                  auth.signOut();
                  Navigator.pushReplacementNamed(context, '/');
                },
              ),
                  LableButton(
                child: Text('Datenschutzerklärung'),
                onPressed: () {
                  auth.signOut();
                  Navigator.pushReplacementNamed(context, '/');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  //öffnet url in der App
  _launchURL() async {
    const url = 'https://teamwork.edubs.ch/appsuite/';
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true);
    } else {
      throw 'Teamwork konnte nicht geöffnet werden';
    }
  }
}
