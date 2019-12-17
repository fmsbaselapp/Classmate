import 'package:Classmate/services/services.dart';
import 'package:Classmate/shared/shared.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sticky_headers/sticky_headers.dart';

class AusfaelleTab extends StatelessWidget {
  AusfaelleTab({
    Key key,
    @required this.report,
  }) : super(key: key);

  final Report report;

  @override
  Widget build(BuildContext context) {
    const double paddingSite = 10;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(
          child: StreamBuilder(
            stream: Firestore.instance
                .collection('Ausfaelle')
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
                      text: 'Keine Ausfälle',
                    ),
                  );
                } else {
                  //Tage.builder
                  return FadeIn(
                    child: new DocumentList(
                      snapshot: snapshot,
                    ),
                  );
                }
              }
            },
          ),
        ),
      ],
    );
  }
}

//DOKUMENTE
class DocumentList extends StatelessWidget {
  DocumentList({
    this.snapshot,
    Key key,
  }) : super(key: key);

  final snapshot;
  @override
  Widget build(BuildContext context) {
    const double paddingSite = 10;
    return ListView.builder(
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
                        color: Theme.of(context).accentColor,
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
                content: new AusfallList(
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
class AusfallList extends StatelessWidget {
  const AusfallList(
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
          if (ausfall.length == 4) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: 30.0,
                child: FadeInAnimation(
                 
                  child: AusfallKarten(ausfall: ausfall),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}


//Ausfall Karten
class AusfallKarten extends StatelessWidget {
  const AusfallKarten({
    Key key,
    @required this.ausfall,
  }) : super(key: key);

  final List<String> ausfall;

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(15.0),
                  topRight: const Radius.circular(15.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 5, left: 10),
              child: Text(
                ausfall[0], //first element from array
                style: Theme.of(context)
                    .textTheme
                    .body2
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: Text(
              ausfall[1], //second element from array
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 5),
            child: Text(
              ausfall[2], //third element from array
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 5, bottom: 10),
            child: Text(
              ausfall[3], //third element from array
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
        ],
      ),
    );
  }
}
