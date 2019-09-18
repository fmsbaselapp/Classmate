import 'package:Classmate/screens/schoolSelect.dart';
import 'package:Classmate/services/models.dart';
import 'package:Classmate/shared/appBar.dart';
import 'package:Classmate/shared/button.dart';
import 'package:flutter/material.dart';
import 'package:Classmate/services/auth.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:Classmate/services/services.dart';
import 'package:Classmate/shared/shared.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Report report = Provider.of<Report>(context);
    AuthService auth = AuthService();

    bool toBeMergedWithAncestors = false;
    bool allowDescendantsToAddSemantics = false;
    String email = report.email;
    print(email);

    return Semantics(
      container: toBeMergedWithAncestors,
      explicitChildNodes: allowDescendantsToAddSemantics,
      child: Scaffold(
        appBar: ClassmateAppBar(
          children: <Widget>[
            RoundButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                size: 30,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text(
                'Einstellungen',
                style: Theme.of(context).textTheme.title,
              ),
            )
          ],
          height: 80,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
        body: ListView(
          padding: const EdgeInsets.only(left: 20, right: 20),
          children: <Widget>[
            LableButtonExtended(
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
                Navigator.pushNamed(context, '/signOut');
              },
            ),
            LableButtonExtended(
              paddingTop: 40,
              child: Text('Nutzungsbedingungen'),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/nutzungsbedingungen');
              },
            ),
            LableButtonExtended(
              paddingTop: 10,
              child: Text('Datenschutzerklärung'),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/datenschutzerklärung');
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
