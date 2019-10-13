import 'package:Classmate/shared/appBar.dart';
import 'package:Classmate/shared/shared.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Datenschutzerklaerung extends StatelessWidget {
  const Datenschutzerklaerung({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: Firestore.instance
            .collection('Datenschutzerklaerung')
            .document('1')
            .snapshots(),
        builder: (context, snapshot) {
          //check if snapshot has data
          if (!snapshot.hasData) {
            return LoadingScreen();

            //if snapshot has data:
          } else {
            return Scaffold(
              appBar: ClassmateAppBar(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: RoundButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        size: 30,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Text(
                          'Datenschutz',overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.title,
                        ),
                      ),
                    ),
                  )
                ],
                height: 80,
              ),
              body: ListView(
                children: <Widget>[
                  LableFettExtended(
                    text: snapshot.data['Datenschutzerklaerung'],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
