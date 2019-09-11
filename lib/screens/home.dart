import 'package:sticky_headers/sticky_headers.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Classmate/shared/shared.dart';

const double paddingSite = 10;

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                child: Text(
                  'Stundenausfälle',
                  style: Theme.of(context).textTheme.title,
                ),
              ),
            ),
          ),

          //liste mit ausfällen und tagen
          Flexible(
            child: StreamBuilder(
              stream: Firestore.instance
                  .collection('FMS Basel')
                  .snapshots(),
              builder: (context, snapshot) {
                //check if snapshot has data
                if (!snapshot.hasData) {
                  return Text("Loading..",
                      style: Theme.of(context).textTheme.title); //TODO loading

                  //if snapshot has data:
                } else {
                  if (snapshot.data.documents.length == 0) {
                    print('keine Dokumente');
                    return Center(
                      child: Text(
                        'keine Ausfälle',
                        style: Theme.of(context).textTheme.title,
                      ),
                    );
                  } else {
                    //Tage.builder
                    return ListView.builder(
                      //document counter
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, indexDocument) {
                        //array counter
                        Map<String, dynamic> ausfallCounter =
                            snapshot.data.documents[indexDocument].data;
                        return Column(
                          children: <Widget>[
                            //titel WOCHENTAG
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
                                          .documents[indexDocument].documentID,
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
                                      margin: EdgeInsets.only(
                                          left: (paddingSite + 10),
                                          right: (paddingSite + 10),
                                          top: (paddingSite + 5)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Column(
                                          
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: <Widget>[
                                            
                                            Text(
                                              ausfall[
                                                  0], //first element from array
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .button,
                                            ),
                                            Text(
                                              ausfall[
                                                  1], //second element from array
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subhead,
                                            ),
                                            Text(
                                              ausfall[
                                                  2], //third element from array
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subhead,
                                            ),
                                            
                                          ],
                                        ),
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
