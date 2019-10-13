import 'package:Classmate/screens/schoolSelect.dart';
import 'package:Classmate/screens/screens.dart';
import 'package:Classmate/services/services.dart';
import 'package:Classmate/shared/appBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Classmate/shared/shared.dart';

const double paddingSite = 10;

class HomeScreenChecker extends StatelessWidget {
  const HomeScreenChecker({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    Report report = Provider.of<Report>(context);

    if (user != null) {
      if (report.schule == '') {
        return SchoolSelectScreenFirst();
      } else {
        return HomeScreen();
      }
    } else {
      return LoginScreen();
    }
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Report report = Provider.of<Report>(context);
    var connectionStatus = Provider.of<ConnectivityStatus>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ClassmateAppBar(
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
              ))
        ],
        height: 80,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
      //Titel
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
<<<<<<< HEAD
          Expanded(
            child: StreamBuilder(
              //TODO initialData: report.schule = 'keine Schule',
              stream: Firestore.instance.collection(report.schule).snapshots(),
              builder: (context, snapshot) {
                //check if snapshot has data
                if (!snapshot.hasData) {
                  return Center(child: Loader());
=======
               Expanded(
      child: StreamBuilder(
        stream: Firestore.instance.collection(report.schule).snapshots(),
        builder: (context, snapshot) {
          //check if snapshot has data
          if (!snapshot.hasData) {
            return Center(child: Text('keine Daten'));
>>>>>>> parent of 496ba67... fixes

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
    ),
/*
          ConditionalBuilder(
            condition: connectionStatus == ConnectivityStatus.Cellular,
            builder: (context) {
              return CheckBuilder(
                report: report,
              );
            },
          ),

          ConditionalBuilder(
            condition: connectionStatus == ConnectivityStatus.WiFi,
            builder: (context) {
              return CheckBuilder(
                report: report,
              );
            },
          ),

          ConditionalBuilder(
            condition: connectionStatus == ConnectivityStatus.Offline,
            builder: (context) {
              return Center(
                child: Loader(),
              );
            },
          ),
          */
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
                    SizedBox(
                      height: 40,
                      width: double.infinity,
                      child: Container(
                        color: Colors.white,
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
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: ausfallCounter.length,
      itemBuilder: (context, index) {
        List<String> ausfall = List.from(
            snapshot.data.documents[indexDocument].data[index.toString()]);

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

