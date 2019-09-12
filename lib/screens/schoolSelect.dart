import 'dart:io';

import 'package:Classmate/shared/Elements.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SchoolSelectScreen extends StatefulWidget {
  const SchoolSelectScreen({Key key}) : super(key: key);

  @override
  _SchoolSelectScreenState createState() => _SchoolSelectScreenState();
}

class _SchoolSelectScreenState extends State<SchoolSelectScreen> {
  int _value1 = 0;
  int _value2 = 0;

  void _setvalue1(int value) => setState(() => _value1 = value);
  void _setvalue2(int value) => setState(() => _value2 = value);

  Widget makeRadioTiles() {
    List<String> schulen = List<String>();
    schulen = [
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
    List<Widget> list = List<Widget>();
    print(schulen);

    for (int i = 0; i < schulen.length; i++) {
      list.add(
        RadioListTile(
            value: i,
            groupValue: _value2,
            onChanged: _setvalue2,
            activeColor: Colors.black,
            controlAffinity: ListTileControlAffinity.platform,
            title: LableFettExtended(
              text: schulen[i],
            )),
      );
    }

    print(_value2);

    Column column = Column(
      children: list,
    );
    return column;
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return Scaffold(
        body: CupertinoScrollbar(
          child: ListView(
            children: <Widget>[makeRadioTiles()],
          ),
        ),
      );
    } else {}
    return Scaffold(
      body: ListView(
        children: <Widget>[makeRadioTiles()],
      ),
    );
  }
}
