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
  final GlobalKey _key = GlobalKey();
  @override
  Widget build(BuildContext context, AufgabenViewModel model) {
    return GestureDetector(
      key: _key,
      onTapDown: (tap) => model.tapDown(tap),
      onTap: () => model.goToDetailPage(context, index, _key),
      // onTap: () => model.goToDetailPage(context, index),
      child: Column(
        children: [
          index == 0
              ? SizedBox(
                  height: 15,
                )
              : Wrap(),
          SizedBox(
            child: Stack(
              children: [
                Stack(
                  children: [
                    Hero(
                      tag: 'Page' + index.toString() + aufgabe.titel,
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    Hero(
                      tag: 'Container' + index.toString() + aufgabe.titel,
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(24, 118, 210, 1),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15)),
                        ),
                      ),
                    ),
                  ],
                ),
                FractionallySizedBox(
                  widthFactor: 0.9,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 10, bottom: 10, left: 15, right: 15),
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
                ),
                Positioned(
                  right: 15,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 15,
                      bottom: 15,
                      left: 15,
                    ),
                    child: AufgabeButton(),
                  ),
                ),
              ],
            ),
          ),
        ],
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
