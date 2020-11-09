import 'package:Classmate/ui/custom_icons_icons.dart';
import 'package:Classmate/ui/shared/export.dart';
import 'package:flutter/material.dart';

class FachUI extends StatelessWidget {
  FachUI({
    Key key,
    this.fach,
    this.zeit,
    this.raum,
    this.icon,
    this.farbe,
  }) : super(key: key);

  final String fach;
  final String raum;
  final String zeit;
  final String icon;
  final int farbe;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(0.00, 5.00),
            color: Color(0xff000000).withOpacity(0.10),
            blurRadius: 20,
          ),
        ],
        borderRadius: BorderRadius.circular(25.00),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: IconFach(icon: icon, farbe: farbe),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(fach,
                        style: Theme.of(context).textTheme.headline2),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 10),
                    child: Text(zeit,
                        style: Theme.of(context).textTheme.bodyText2),
                  ),
                ],
              ),
            ],
          ),
          RoundButton(icon: CustomIcons.add, iconSize: 15, onPressed: () {})
        ],
      ),
    );
  }
}

class FachUIerstellen extends StatelessWidget {
  FachUIerstellen({
    Key key,
    this.fach,
    this.icon,
    this.farbe,
  }) : super(key: key);

  final String fach;
  final String icon;
  final int farbe;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).highlightColor,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconFach(icon: icon, farbe: farbe),
          ),
          Text(fach, style: Theme.of(context).textTheme.headline2),
        ],
      ),
    );
  }
}
