import 'package:Classmate/services/models.dart';
import 'package:Classmate/shared/button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Classmate/services/auth.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';


class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Report report = Provider.of<Report>(context);
    bool toBeMergedWithAncestors = false;
    bool allowDescendantsToAddSemantics = false;

    AuthService auth = AuthService();
    FirebaseUser user = Provider.of<FirebaseUser>(context);
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
        body: ListView(
          padding: const EdgeInsets.only(left: 10, right: 10),
          children: <Widget>[
            StreamBuilder(
              //TODOD wrap whole screen in streambuilder
              stream: Firestore.instance
                  .collection('Nutzer')
                  .document(user.uid)
                  .snapshots(),
              builder: (context, snapshotSchule) {
                return LableButtonExtended(
                  paddingTop: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Meine Schule:'),
                      Text(
                       report.schule, //Todo
                        style: Theme.of(context).textTheme.subhead,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/schoolSelect');
                  },
                );
              },
            ),
            LableButtonExtended(
              paddingTop: 40,
              child: Text('Teamwork öffnen'),
              onPressed: () {
                _launchURL();
              },
            ),
            LableButtonExtended(
              paddingTop: 10,
              child: Text('Gratis Office, Word, Powerpoint'),
              onPressed: () {},
            ),
            LableButtonExtended(
              paddingTop: 40,
              child: Text('Abmelden'),
              onPressed: () {
                auth.signOut();
                Navigator.pushNamed(context, '/');
              },
            ),
            LableButtonExtended(
              paddingTop: 40,
              child: Text('Nutzungsbedingungen'),
              onPressed: () {
                auth.signOut();
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
            LableButtonExtended(
              paddingTop: 10,
              child: Text('Datenschutzerklärung'),
              onPressed: () {
                auth.signOut();
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
          ],
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
