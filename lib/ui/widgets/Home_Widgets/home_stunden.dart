import 'package:Classmate/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Home_Stunden extends StatelessWidget {
  Home_Stunden({
    Key key,
    this.fach,
    this.zeit,
    this.raum,
  }) : super(key: key);

  String fach;
  String raum;
  String zeit;

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
              child: Icon_Fach(),
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
