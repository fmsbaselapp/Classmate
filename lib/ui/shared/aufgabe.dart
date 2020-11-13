import 'package:Classmate/models/models.dart';
import 'package:Classmate/ui/views/aufgaben/aufgaben_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'export.dart';

class AufgabeBig extends ViewModelWidget<AufgabenViewModel> {
  AufgabeBig({
    @required this.aufgabe,
    @required this.index,
    Key key,
  }) : super(key: key);

  @override
  bool get reactive => true;

  final Aufgabe aufgabe;
  final int index;
  //final GlobalKey _key = GlobalKey();
  @override
  Widget build(BuildContext context, AufgabenViewModel model) {
    return GestureDetector(
      //key: _key,
      onTapDown: (tap) => model.tapDown(tap),
      //onTap: () => model.goToDetailPage(context, _key),
      onTap: () => model.goToDetailPage(context, index),
      child: Transform.scale(
        scale: model.scale,
        child: Stack(
          children: [
            Hero(
              tag: 'Container' + index.toString() + aufgabe.titel,
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 15),
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(24, 118, 210, 1),
                  borderRadius: BorderRadius.circular(15.00),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AufgabeButton(),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 20,
              bottom: 5,
              left: 15,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //STACK
                  Hero(
                    tag: 'Title' + index.toString() + aufgabe.titel,
                    child: Text(
                      aufgabe.titel,
                      style: Theme.of(context).textTheme.headline2,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconFach(
                        farbe: aufgabe.fachFarbe,
                        icon: aufgabe.fachIcon,
                        small: true,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        aufgabe.fachName +
                            ' | ' +
                            aufgabe.datum.weekday.toString() +
                            ',' +
                            aufgabe.datum.day.toString() +
                            aufgabe.datum.month.toString(),
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AufgabeSmall extends StatelessWidget {
  const AufgabeSmall({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
