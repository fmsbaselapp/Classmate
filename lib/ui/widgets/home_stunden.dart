import 'package:Classmate/ui/shared/export.dart';
import 'package:flutter/material.dart';

class HomeStunden extends StatelessWidget {
  HomeStunden({
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
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: 135),
      child: Container(
        padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          boxShadow: [
            BoxShadow(
              offset: Offset(0.00, 5.00),
              color: Color(0xff000000).withOpacity(0.10),
              blurRadius: 20,
            ),
          ],
          borderRadius: BorderRadius.circular(20.00),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: IconFach(icon: icon, farbe: farbe),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(fach, style: Theme.of(context).textTheme.headline2),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Text(zeit, style: Theme.of(context).textTheme.bodyText2),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Text(raum, style: Theme.of(context).textTheme.bodyText2),
            ),
          ],
        ),
      ),
    );
  }
}
