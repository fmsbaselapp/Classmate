import 'package:Classmate/services/services.dart';
import 'package:Classmate/shared/appBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Classmate/shared/Elements.dart';
import 'package:Classmate/shared/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

FirebaseAnalytics analytics = FirebaseAnalytics();

class SchoolSelectScreen extends StatefulWidget {
  SchoolSelectScreen({Key key, this.report}) : super(key: key);
  Report report;

  @override
  _SchoolSelectScreenState createState() =>
      _SchoolSelectScreenState(report: report);
}

class _SchoolSelectScreenState extends State<SchoolSelectScreen> {
  _SchoolSelectScreenState({@required this.report});

  Report report;
  List<String> schulenlist = List<String>();
  final schulenL = [
    'FMS Basel',
    'Gymnasium am Münsterplatz',
    'Gymnasium Bäumlihof',
    'Gymnasium Kirschgarten',
    'Gymnasium Leonhard',
    'WG und WMS',
    'Sekundar Bäumlihof',
    'Sekundar De Wette',
    'Sekundar Drei Linden',
    'Sekundar Holbein',
    'Sekundar Leonhard',
    'Sekundar Sandgruben',
    'Sekundar St. Alban',
    'Sekundar Theobald Baerwart',
    'Sekundar Vogesen',
    'Sekundar Wasgenring',
    'St. Johann',
    'Thierstein',
    'Dreirosen',
    'Isaak Iselin',
    'Kleinhüningen',
    'Fachzentrum Gestalten',
    'Tagesstrukturen Drei Linden',
    'ZBA Gundeldingen',
    'ZBA Letzi'
        'BFS Gebäude A',
    'BFS Gebäude B',
    'BFS Gebäude C',
    'BFS Gebäude D',
    'PZ.BS Bibliothek',
    'PZ.BS medialab',
  ];
  int schule;
  @override
  void initState() {
    String schoolindex = report.schule;
    _value2 = wichSchoolIndex(schoolindex);

    super.initState();
  }

  int _value1 = 0;
  int _value2; //Todo

  void _setvalue1(int value) => setState(() => _value1 = value);
  void _setvalue2(int value) => setState(() => _value2 = value);

  Widget schulen() {
    List<String> schulenlist = List<String>();
    schulenlist = [
      'FMS Basel',
      'Gymnasium am Münsterplatz',
      'Gymnasium Bäumlihof',
      'Gymnasium Kirschgarten',
      'Gymnasium Leonhard',
      'WG und WMS',
      'Sekundar Bäumlihof',
      'Sekundar De Wette',
      'Sekundar Drei Linden',
      'Sekundar Holbein',
      'Sekundar Leonhard',
      'Sekundar Sandgruben',
      'Sekundar St. Alban',
      'Sekundar Theobald Baerwart',
      'Sekundar Vogesen',
      'Sekundar Wasgenring',
      'St. Johann',
      'Thierstein',
      'Dreirosen',
      'Isaak Iselin',
      'Kleinhüningen',
      'Fachzentrum Gestalten',
      'Tagesstrukturen Drei Linden',
      'ZBA Gundeldingen',
      'ZBA Letzi',
      'BFS Gebäude A',
      'BFS Gebäude B',
      'BFS Gebäude C',
      'BFS Gebäude D',
      'PZ.BS Bibliothek',
      'PZ.BS medialab',
    ];
    List<Widget> list = List<Widget>();

    for (int i = 0; i < schulenlist.length; i++) {
      if (_value2 == null) {
        _value2 = schule;
      }
      schule = _value2;
      list.add(
        RadioListTile(
          value: i,
          groupValue: schule,
          onChanged: _setvalue2,
          activeColor: Theme.of(context).indicatorColor,
          controlAffinity: ListTileControlAffinity.platform,
          title: LableFettExtendedSansPadding(
            text: schulenlist[i],
          ),
        ),
      );
    }

    Column column = Column(
      children: list,
    );
    return Padding(padding: EdgeInsets.only(bottom: 10), child: column);
  }

  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      appBar: ClassmateAppBar(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        height: 60,
        children: <Widget>[
          Text(
            'Schule',
            style: Theme.of(context).textTheme.title,
          ),
          SmallButton(
            onPressed: () async {
              List<String> schulenlist = List<String>();

              schulenlist = [
                'FMS',
                'Gymnasium am Münsterplatz',
                'Gymnasium Bäumlihof',
                'Gymnasium Kirschgarten',
                'Gymnasium Leonhard',
                'WG und WMS',
                'Sekundar Bäumlihof',
                'Sekundar De Wette',
                'Sekundar Drei Linden',
                'Sekundar Holbein',
                'Sekundar Leonhard',
                'Sekundar Sandgruben',
                'Sekundar St. Alban',
                'Sekundar Theobald Baerwart',
                'Sekundar Vogesen',
                'Sekundar Wasgenring',
                'St. Johann',
                'Thierstein',
                'Dreirosen',
                'Isaak Iselin',
                'Kleinhüningen',
                'Fachzentrum Gestalten',
                'Tagesstrukturen Drei Linden',
                'ZBA Gundeldingen',
                'ZBA Letzi',
                'BFS Gebäude A',
                'BFS Gebäude B',
                'BFS Gebäude C',
                'BFS Gebäude D',
                'PZ.BS Bibliothek',
                'PZ.BS medialab',
              ];

              final Firestore _db = Firestore.instance;
              FirebaseUser user = Provider.of<FirebaseUser>(context);
              if (user != null) {
                Future<void> loadSchool(FirebaseUser user) async {
                  DocumentReference reportRef =
                      _db.collection('Nutzer').document(user.uid);

                  return reportRef.setData(
                      {'uid': user.uid, 'Schule': schulenlist[_value2]},
                      merge: true);
                }

                FirebaseAnalytics().setUserProperty(
                    name: "Schule", value: schulenlist[_value2]);
                loadSchool(user);
                print(schulenlist[_value2]);

                Navigator.pop(context);
              } else {
                print('nicht angemeldet');
                Navigator.pushReplacementNamed(context, '/login');
              }
            },
            child: Text('Fertig'),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: CupertinoScrollbar(
            child: ListView(
              children: <Widget>[schulen()],
            ),
          ),
        ),
      ),
    );
  }
}

wichSchoolIndex(schoolindex) {
  if (schoolindex == 'FMS') {
    return 0;
  } else if (schoolindex == 'Gymnasium am Münsterplatz') {
    return 1;
  } else if (schoolindex == 'Gymnasium Bäumlihof') {
    return 2;
  } else if (schoolindex == 'Gymnasium Kirschgarten') {
    return 3;
  } else if (schoolindex == 'Gymnasium Leonhard') {
    return 4;
  } else if (schoolindex == 'WG und WMS') {
    return 5;
  } else if (schoolindex == 'Sekundar Bäumlihof') {
    return 6;
  } else if (schoolindex == 'Sekundar De Wette') {
    return 7;
  } else if (schoolindex == 'Sekundar Drei Linden') {
    return 8;
  } else if (schoolindex == 'Sekundar Holbein') {
    return 9;
  } else if (schoolindex == 'Sekundar Leonhard') {
    return 10;
  } else if (schoolindex == 'Sekundar Sandgruben') {
    return 11;
  } else if (schoolindex == 'Sekundar St. Alban') {
    return 12;
  } else if (schoolindex == 'Sekundar Theobald Baerwart') {
    return 13;
  } else if (schoolindex == 'Sekundar Vogesen') {
    return 14;
  } else if (schoolindex == 'Sekundar Wasgenring') {
    return 15;
  } else if (schoolindex == 'St. Johann') {
    return 16;
  } else if (schoolindex == 'Thierstein') {
    return 17;
  } else if (schoolindex == 'Dreirosen') {
    return 18;
  } else if (schoolindex == 'Isaak Iselin') {
    return 19;
  } else if (schoolindex == 'Kleinhüningen') {
    return 20;
  } else if (schoolindex == 'Fachzentrum Gestalten') {
    return 21;
  } else if (schoolindex == 'Tagesstrukturen Drei Linden') {
    return 22;
  } else if (schoolindex == 'ZBA Gundeldingen') {
    return 23;
  } else if (schoolindex == 'ZBA Letzi') {
    return 24;
  } else if (schoolindex == 'BFS Gebäude A') {
    return 25;
  } else if (schoolindex == 'BFS Gebäude B') {
    return 26;
  } else if (schoolindex == 'BFS Gebäude C') {
    return 27;
  } else if (schoolindex == 'BFS Gebäude D') {
    return 28;
  } else if (schoolindex == 'PZ.BS Bibliothek') {
    return 29;
  } else if (schoolindex == 'PZ.BS medialab') {
    return 30;
  }
}

//=========================================================================================================================

//First open
class SchoolSelectScreenFirst extends StatefulWidget {
  const SchoolSelectScreenFirst({Key key}) : super(key: key);

  @override
  _SchoolSelectScreenStateFirst createState() =>
      _SchoolSelectScreenStateFirst();
}

class _SchoolSelectScreenStateFirst extends State<SchoolSelectScreenFirst> {
  int _value1 = 0;
  int _value2;

  void _setvalue1(int value) => setState(() => _value1 = value);
  void _setvalue2(int value) => setState(() => _value2 = value);

  Widget schulen() {
    List<String> schulenlist = List<String>();
    schulenlist = [
      'FMS Basel',
      'Gymnasium am Münsterplatz',
      'Gymnasium Bäumlihof',
      'Gymnasium Kirschgarten',
      'Gymnasium Leonhard',
      'WG und WMS',
      'Sekundar Bäumlihof',
      'Sekundar De Wette',
      'Sekundar Drei Linden',
      'Sekundar Holbein',
      'Sekundar Leonhard',
      'Sekundar Sandgruben',
      'Sekundar St. Alban',
      'Sekundar Theobald Baerwart',
      'Sekundar Vogesen',
      'Sekundar Wasgenring',
      'St. Johann',
      'Thierstein',
      'Dreirosen',
      'Isaak Iselin',
      'Kleinhüningen',
      'Fachzentrum Gestalten',
      'Tagesstrukturen Drei Linden',
      'ZBA Gundeldingen',
      'ZBA Letzi',
      'BFS Gebäude A',
      'BFS Gebäude B',
      'BFS Gebäude C',
      'BFS Gebäude D',
      'PZ.BS Bibliothek',
      'PZ.BS medialab',
    ];
    List<Widget> list = List<Widget>();

    for (int i = 0; i < schulenlist.length; i++) {
      list.add(
        RadioListTile(
          value: i,
          groupValue: _value2,
          onChanged: _setvalue2,
          activeColor: Theme.of(context).indicatorColor,
          controlAffinity: ListTileControlAffinity.platform,
          title: LableFettExtendedSansPadding(
            text: schulenlist[i],
          ),
        ),
      );
    }

    Column column = Column(
      children: list,
    );
    return Padding(padding: EdgeInsets.only(bottom: 10), child: column);
  }

  Widget build(
    BuildContext context,
  ) {
    return WillPopScope(
      onWillPop: () async {
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColorDark,
        appBar: ClassmateAppBar(
          height: 100,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Deine\nSchule:',
              style: Theme.of(context).textTheme.title,
            ),
            SmallButton(
              onPressed: () async {
                List<String> schulenlist = List<String>();

                schulenlist = [
                  'FMS',
                  'Gymnasium am Münsterplatz',
                  'Gymnasium Bäumlihof',
                  'Gymnasium Kirschgarten',
                  'Gymnasium Leonhard',
                  'WG und WMS',
                  'Sekundar Bäumlihof',
                  'Sekundar De Wette',
                  'Sekundar Drei Linden',
                  'Sekundar Holbein',
                  'Sekundar Leonhard',
                  'Sekundar Sandgruben',
                  'Sekundar St. Alban',
                  'Sekundar Theobald Baerwart',
                  'Sekundar Vogesen',
                  'Sekundar Wasgenring',
                  'St. Johann',
                  'Thierstein',
                  'Dreirosen',
                  'Isaak Iselin',
                  'Kleinhüningen',
                  'Fachzentrum Gestalten',
                  'Tagesstrukturen Drei Linden',
                  'ZBA Gundeldingen',
                  'ZBA Letzi',
                  'BFS Gebäude A',
                  'BFS Gebäude B',
                  'BFS Gebäude C',
                  'BFS Gebäude D',
                  'PZ.BS Bibliothek',
                  'PZ.BS medialab',
                ];

                final Firestore _db = Firestore.instance;
                FirebaseUser user = Provider.of<FirebaseUser>(context);
                if (user != null) {
                  Future<void> loadSchool(FirebaseUser user) {
                    DocumentReference reportRef =
                        _db.collection('Nutzer').document(user.uid);

                    return reportRef.updateData(
                      {'uid': user.uid, 'Schule': schulenlist[_value2]},
                    );
                  }

                  loadSchool(user);
                  print(schulenlist[_value2]);
                  FirebaseAnalytics().setUserProperty(
                      name: "Schule", value: schulenlist[_value2]);
                  // Navigator.pushReplacementNamed(context, '/home');
                } else {
                  print('nicht angemeldet');
                  Navigator.pushReplacementNamed(context, '/login');
                }
              },
              child: Text('Weiter'),
            )
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: CupertinoScrollbar(
              child: ListView(
                children: <Widget>[schulen()],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
