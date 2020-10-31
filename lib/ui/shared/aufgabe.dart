import 'package:Classmate/models/models.dart';
import 'package:Classmate/ui/custom_icons_icons.dart';

import 'package:flutter/material.dart';

import 'export.dart';

class Aufgabe_Big extends StatelessWidget {
  Aufgabe_Big({
    @required this.aufgabe,
    Key key,
  }) : super(key: key);

  Aufgabe aufgabe;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
      decoration: BoxDecoration(
        color: Color.fromRGBO(24, 118, 210, 1),
        borderRadius: BorderRadius.circular(15.00),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                aufgabe.titel,
                style: Theme.of(context).textTheme.headline2,
              ),
              Row(
                children: [
                  Text(
                    aufgabe.fach.name + ' | ' + aufgabe.datum,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ],
          ),
          Round_Button(icon: CustomIcons.add, iconSize: 15, onPressed: () {}),
        ],
      ),
    );
  }
}

class Aufgabe_Small extends StatelessWidget {
  const Aufgabe_Small({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
