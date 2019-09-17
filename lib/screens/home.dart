import 'package:Classmate/services/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Classmate/shared/shared.dart';



const double paddingSite = 10;

class HomeScreenChecker extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    Report report = Provider.of<Report>(context);
    return Scaffold(
      backgroundColor: Colors.white,

      //Titel
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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
                  .collection(report.schule)
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
                                content: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: ausfallCounter.length,
                                  itemBuilder: (context, index) {
                                    List<String> ausfall = List.from(snapshot
                                        .data
                                        .documents[indexDocument]
                                        .data[index.toString()]);

                                    //Ausfall Karten
                                    return Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(15.0)),
                                      elevation: 5,
                                      margin: EdgeInsets.only(
                                          left: (paddingSite + 10),
                                          right: (paddingSite + 10),
                                          top: (paddingSite + 5)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  new BorderRadius.only(
                                                      topLeft:
                                                          const Radius.circular(
                                                              15.0),
                                                      topRight:
                                                          const Radius.circular(
                                                              15.0)),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10, bottom: 5, left: 10),
                                              child: Text(
                                                ausfall[
                                                    0], //first element from array
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .body2,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, top: 10),
                                            child: Text(
                                              ausfall[
                                                  1], //second element from array
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subhead,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, top: 5),
                                            child: Text(
                                              ausfall[
                                                  2], //third element from array
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subhead,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, top: 5, bottom: 10),
                                            child: Text(
                                              ausfall[
                                                  3], //third element from array
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subhead,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
