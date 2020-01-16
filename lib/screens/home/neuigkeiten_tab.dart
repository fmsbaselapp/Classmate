import 'package:Classmate/services/services.dart';
import 'package:Classmate/shared/shared.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:share/share.dart';
import 'package:sticky_headers/sticky_headers.dart';

class NeuigkeitenTab extends StatelessWidget {
  NeuigkeitenTab({
    Key key,
    @required this.report,
  }) : super(key: key);

  final Report report;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('Neuigkeiten')
          .document('Schulen')
          .collection(report.schule)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
          return Center(child: Loader());
        }
        //check if snapshot has data
        if (!snapshot.hasData) {
          print(snapshot.data);
          return Center(child: Loader());

          //if snapshot has data:
        } else {
          if (snapshot.data.documents.length == 0) {
            print('keine Dokumente');

            return FadeIn(
              child: LableFettExtended(
                text: 'Keine Neuigkeiten',
              ),
            );
          } else {
            //Tage.builder
            return FadeIn(
              child: new _DocumentList(
                snapshot: snapshot,
              ),
            );
          }
        }
      },
    );
  }
}

//DOKUMENTE
class _DocumentList extends StatelessWidget {
  _DocumentList({
    this.snapshot,
    Key key,
  }) : super(key: key);

  final snapshot;
  @override
  Widget build(BuildContext context) {
    const double paddingSite = 10;
    return ListView.builder(
      shrinkWrap: true,
      physics: AlwaysScrollableScrollPhysics(),
      //document counter
      itemCount: snapshot.data.documents.length,
      itemBuilder: (context, indexDocument) {
        //array counter
        Map<String, dynamic> ausfallCounter =
            snapshot.data.documents[indexDocument].data;
        return Column(
          children: <Widget>[
            //WOCHENTAG
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: StickyHeader(
                header: Stack(
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                      width: double.infinity,
                      child: Container(
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ),
                    LableFettExtended(
                      margin: paddingSite,
                      text: snapshot.data.documents[indexDocument].documentID
                          .toString()
                          .substring(1),
                    ),
                  ],
                  overflow: Overflow.visible,
                ),

                // Ausfälle.builder
                content: new _AusfallList(
                  ausfallCounter: ausfallCounter,
                  snapshot: snapshot,
                  indexDocument: indexDocument,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

//AUSFÄLLE
class _AusfallList extends StatelessWidget {
  const _AusfallList(
      {Key key,
      @required this.ausfallCounter,
      @required this.snapshot,
      @required this.indexDocument})
      : super(key: key);

  final Map<String, dynamic> ausfallCounter;
  final snapshot;
  final indexDocument;

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: ausfallCounter.length,
        itemBuilder: (BuildContext context, int index) {
          List<String> ausfall = List.from(
              snapshot.data.documents[indexDocument].data[index.toString()]);
          String ausfallTitel = ausfall[0].toString();

          ausfall.removeAt(0);
          List<String> ausfallContent = ausfall;
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 30.0,
              child: FadeInAnimation(
                child: _AusfallKarten(
                  ausfallTitel: ausfallTitel,
                  ausfallContent: ausfallContent,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

//Ausfall Karten
class _AusfallKarten extends StatelessWidget {
  const _AusfallKarten({
    Key key,
    @required this.ausfallTitel,
    @required this.ausfallContent,
  }) : super(key: key);

  final String ausfallTitel;
  final List<String> ausfallContent;

  @override
  Widget build(BuildContext context) {
    const double paddingSite = 10;
    return Card(
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
      elevation: 5,
      margin: EdgeInsets.only(
          left: (paddingSite + 10),
          right: (paddingSite + 10),
          top: (paddingSite + 5)),
      child: InkWell(
        onTap: () => Share.share(
            '\nNeuigkeit:\n$ausfallTitel\n${ausfallContent[0]}\n\nAusfälle in der App:\nhttps://appclassmate.page.link/classmate'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(15.0),
                    topRight: const Radius.circular(15.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 5, left: 10, right: 10),
                child: Text(
                  ausfallTitel, //first element from array
                  style: Theme.of(context)
                      .textTheme
                      .body2
                      .copyWith(color: Colors.white),
                ),
              ),
            ),

            //Titel

            Padding(
              padding: EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  for (var text in ausfallContent)
                    Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          text,
                          style: Theme.of(context).textTheme.subhead,
                        ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
