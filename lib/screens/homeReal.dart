import 'package:Classmate/services/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Classmate/shared/shared.dart';

class HomeScreenChecker extends StatelessWidget {
  const HomeScreenChecker({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    final schuleDB = SchuleDB();

    bool loggedIn = user != null;

    return Column(
      children: <Widget>[
        if (loggedIn)
          StreamProvider<Schule>.value(
            // All children will have access to SuperHero data
            stream: schuleDB.schuleStream(user),
            child: HomeScreen(),
          ),
      ],
    );
  }
}

const double paddingSite = 10;

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    var schule = Provider.of<Schule>(context);
   
    print(schule.schule);
    return Scaffold(
      backgroundColor: Colors.white,

      //Titel
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //TODO
          Padding(
            padding:
                const EdgeInsets.only(left: paddingSite, right: paddingSite),
            child: Container(
              width: double.infinity,
              height: 70,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 30,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Ausfälle',
                      style: Theme.of(context).textTheme.title,
                    ),
                    RoundButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/settings');
                      },
                      child: Icon(
                        Icons.settings,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          //Streambuilder für Ausfälle und Tage
          Flexible(
            child: StreamBuilder(
              stream: Firestore.instance
                  .collection('Gymnasium Leonhard')
                  .snapshots(),
              builder: (context, snapshot) {
                //check if snapshot has data
                if (!snapshot.hasData) {
                  return Text("Lädt..",
                          style: Theme.of(context).textTheme.title); //TODO loading

                  //if snapshot has data:
                } else {
                  if (snapshot.data.documents.length == 0) {
                    print('keine Dokumente');

                    return Padding(
                      padding: const EdgeInsets.only(top: paddingSite),
                      child: LableFettExtended(
                        text: 'Keine Ausfälle',
                      ),
                    );
                  } else {
                    //Tage.builder
                    return new DocumentList(
                      snapshot: snapshot,
                    );
                  }
                }
              },
            ),
          )
        ],
      ),
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
                    Container(
                      height: 30,
                      width: double.infinity,
                      color: Colors.white,
                    ),
                    LableFettExtended(
                      margin: paddingSite,
                      text: snapshot.data
                      .documents[indexDocument].documentID
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
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: ausfallCounter.length,
      itemBuilder: (context, index) {
        List<String> ausfall = List.from(snapshot
        .data
            .documents[indexDocument]
            .data[index.toString()]);

        return new AusfallKarten(ausfall: ausfall);
      },
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
                style: Theme.of(context).textTheme.body2,
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
