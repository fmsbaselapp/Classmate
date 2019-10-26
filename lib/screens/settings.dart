import 'package:Classmate/screens/schoolSelect.dart';
import 'package:Classmate/services/models.dart';
import 'package:Classmate/shared/appBar.dart';
import 'package:Classmate/shared/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:Classmate/services/services.dart';
import 'package:Classmate/shared/shared.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Report report = Provider.of<Report>(context);

    bool toBeMergedWithAncestors = false;
    bool allowDescendantsToAddSemantics = false;

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
            Expanded(
              child: Container(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Text(
                    'Einstellungen',
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
              ),
            )
          ],
          height: 80,
        ),
        body: ListView(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
          children: <Widget>[
            LableButtonExtended(
              paddingTop: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Meine Schule:'),
                  Text(
                    report.schule.toString() ?? '', //Todo
                    style: Theme.of(context).textTheme.subhead,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SchoolSelectScreen(
                    schoolindex: report.schule,
                  ),
                ));
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
              child: Text('Edubs Angebote'),
              onPressed: () {
               launch('https://classmateapp.ch/edubs-angebote/');
              },
            ),
             LableButtonExtended(
              paddingTop: 40,
              child: Text('Kontakt'),
              onPressed: () {
                launch('https://classmateapp.ch/ueber-uns/');
              },
            ),
            LableButtonExtended(
              paddingTop: 10,
              child: Text('Abmelden'),
              onPressed: () {
                Navigator.pushNamed(context, '/signOut');
              },
            ),
            LableButtonExtended(
              paddingTop: 40,
              child: Text('Nutzungsbedingungen'),
              onPressed: () {
                launch('https://classmateapp.ch/nutzungsbedingungen/');
              },
            ),
            LableButtonExtended(
              paddingTop: 10,
              child: Text('Datenschutzerklärung'),
              onPressed: () {
                launch('https://classmateapp.ch/datenschutz/');
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
