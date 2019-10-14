import 'package:Classmate/shared/appBar.dart';
import 'package:Classmate/shared/shared.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Classmate/shared/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SchoolSelectScreen extends StatefulWidget {
   SchoolSelectScreen({Key key, this.schoolindex}) : super(key: key);
   String schoolindex;//TODO get schoolindex
  @override
  _SchoolSelectScreenState createState() => _SchoolSelectScreenState();
}

class _SchoolSelectScreenState extends State<SchoolSelectScreen> {





int schoolIndex; 
  
  int _value1 = 0;
  int _value2;


  


  void _setvalue1(int value) => setState(() => _value1 = value);
  void _setvalue2(int value) => setState(() => _value2 = value);

  Widget schulen() {
    List<String> schulenlist = List<String>();
    schulenlist = [
      'BFS Gebäude A',
      'BFS Gebäude B',
      'BFS Gebäude C',
      'BFS Gebäude D',
      'Dreirosen',
      'Fachzentrum Gestalten',
      'FMS Basel',
      'Gymnasium am Münsterplatz',
      'Gymnasium Bäumlihof',
      'Gymnasium Kirschgarten',
      'Gymnasium Leonhard',
      'Isaak Iselin',
      'Kleinhüningen',
      'PZ.BS Bibliothek',
      'PZ.BS medialab',
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
      'Tagesstrukturen Drei Linden',
      'Thierstein',
      'WG und WMS',
      'ZBA Gundeldingen',
      'ZBA Letzi'
    ];
    List<Widget> list = List<Widget>();

    for (int i = 0; i < schulenlist.length; i++) {
        if (_value2 == null) {
    _value2 = schoolIndex;
  }
      schoolIndex = _value2;
      list.add(
        RadioListTile(
          value: i,
          groupValue: schoolIndex,
          onChanged: _setvalue2,
          activeColor: Colors.black,
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
    return column;
  }

  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: ClassmateAppBar(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        height: 90,
        children: <Widget>[
          Text(
            'Schule',
            style: Theme.of(context).textTheme.title,
          ),
          SmallButton(
            onPressed: () async {
              List<String> schulenlist = List<String>();

              schulenlist = [
                'BFS Gebäude A',
                'BFS Gebäude B',
                'BFS Gebäude C',
                'BFS Gebäude D',
                'Dreirosen',
                'Fachzentrum Gestalten',
                'FMS',
                'Gymnasium am Münsterplatz',
                'Gymnasium Bäumlihof',
                'Gymnasium Kirschgarten',
                'Gymnasium Leonhard',
                'Isaak Iselin',
                'Kleinhüningen',
                'PZ.BS Bibliothek',
                'PZ.BS medialab',
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
                'Tagesstrukturen Drei Linden',
                'Thierstein',
                'WG und WMS',
                'ZBA Gundeldingen',
                'ZBA Letzi'
              ];

              final Firestore _db = Firestore.instance;
              FirebaseUser user = Provider.of<FirebaseUser>(context);
              if (user != null) {
                Future<void> loadSchool(FirebaseUser user) {
                  DocumentReference reportRef =
                      _db.collection('Nutzer').document(user.uid);

                  return reportRef.setData(
                      {'uid': user.uid, 'Schule': schulenlist[_value2]},
                      merge: true);
                }

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
        child: CupertinoScrollbar(
          child: ListView(
            children: <Widget>[schulen()],
          ),
        ),
      ),
    );
  }
}

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
      'BFS Gebäude A',
      'BFS Gebäude B',
      'BFS Gebäude C',
      'BFS Gebäude D',
      'Dreirosen',
      'Fachzentrum Gestalten',
      'FMS Basel',
      'Gymnasium am Münsterplatz',
      'Gymnasium Bäumlihof',
      'Gymnasium Kirschgarten',
      'Gymnasium Leonhard',
      'Isaak Iselin',
      'Kleinhüningen',
      'PZ.BS Bibliothek',
      'PZ.BS medialab',
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
      'Tagesstrukturen Drei Linden',
      'Thierstein',
      'WG und WMS',
      'ZBA Gundeldingen',
      'ZBA Letzi'
    ];
    List<Widget> list = List<Widget>();

    for (int i = 0; i < schulenlist.length; i++) {
      list.add(
        RadioListTile(
          value: i,
          groupValue: _value2,
          onChanged: _setvalue2,
          activeColor: Colors.black,
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
    return column;
  }

  Widget build(
    BuildContext context,
  ) {
    return WillPopScope(
      onWillPop: () async {
        return Future.value(false);
      },
      child: Scaffold(
        appBar: ClassmateAppBar(
          height: 130,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Wähle deine\nSchule',
              style: Theme.of(context).textTheme.title,
            ),
            SmallButton(
              onPressed: () async {
                List<String> schulenlist = List<String>();

                schulenlist = [
                  'BFS Gebäude A',
                  'BFS Gebäude B',
                  'BFS Gebäude C',
                  'BFS Gebäude D',
                  'Dreirosen',
                  'Fachzentrum Gestalten',
                  'FMS',
                  'Gymnasium am Münsterplatz',
                  'Gymnasium Bäumlihof',
                  'Gymnasium Kirschgarten',
                  'Gymnasium Leonhard',
                  'Isaak Iselin',
                  'Kleinhüningen',
                  'PZ.BS Bibliothek',
                  'PZ.BS medialab',
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
                  'Tagesstrukturen Drei Linden',
                  'Thierstein',
                  'WG und WMS',
                  'ZBA Gundeldingen',
                  'ZBA Letzi'
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
