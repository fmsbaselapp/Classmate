import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:Classmate/services/services.dart';
import 'package:Classmate/shared/shared.dart';
import 'package:Classmate/screens/screens.dart';

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
        backgroundColor: Theme.of(context).primaryColorDark,
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
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Text(
                    'Einstellungen',
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
              ),
            ),
          ],
          height: 60,
        ),
        body: ListView(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: LableButtonExtended(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Schule:'),
                            AnimatedDefaultTextStyle(
                              style: Theme.of(context).textTheme.subhead,
                              duration: Duration(milliseconds: 200),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 1),
                                child: Text(
                                  report.schule.toString() ??
                                      'Wähle deine Schule', //Todo

                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SchoolSelectScreen(
                                report: report,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: LableButtonExtended(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Klasse:'),
                            AnimatedDefaultTextStyle(
                              style: Theme.of(context).textTheme.subhead,
                              duration: Duration(milliseconds: 200),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 1),
                                child: Text(
                                  report.klasse.toString() ??
                                      'Wähle deine Klasse', //Todo

                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ClassSelectScreen(report: report,),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            LableDarkMode(
              text: 'Dunkles Design',
              margin: EdgeInsetsDirectional.only(top: 30),
            ),
            LableButtonExtended(
              paddingTop: 30,
              text: 'Teamwork öffnen',
              onPressed: () {
                _launchURL();
              },
            ),
            LableButtonExtended(
              paddingTop: 10,
              text: 'Edubs Angebote',
              onPressed: () {
                launch('https://classmateapp.ch/edubs-angebote/');
              },
            ),
            LableButtonExtended(
              paddingTop: 30,
              text: 'Hilfe',
              onPressed: () {
                launch('https://classmateapp.ch/hilfe/');
              },
            ),
            LableButtonExtended(
              paddingTop: 10,
              text: 'Kontakt',
              onPressed: () {
                launch('https://classmateapp.ch/kontakt/');
              },
            ),
            LableButtonExtended(
              paddingTop: 10,
              text: 'Abmelden',
              onPressed: () => showPlatformDialog(
                context: context,
                builder: (_) => PlatformAlertDialog(
                  title: Text('Abmelden'),
                  content: Text('Bist du dir sicher?'),
                  actions: <Widget>[
                    PlatformDialogAction(
                      child: PlatformText('Abbrechen'),
                      onPressed: () => Navigator.pop(context),
                    ),
                    PlatformDialogAction(
                      child: PlatformText('Abmelden :('),
                      onPressed: () => Navigator.pushNamed(context, '/signOut'),
                    ),
                  ],
                ),
              ),
            ),
            LableButtonExtended(
              paddingTop: 30,
              text: 'Nutzungsbedingungen',
              onPressed: () {
                launch('https://classmateapp.ch/nutzungsbedingungen/');
              },
            ),
            LableButtonExtended(
              paddingTop: 10,
              text: 'Datenschutzerklärung',
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
