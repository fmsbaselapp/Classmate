import 'package:Classmate/services/services.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,

      //StreamBuilder
      body: StreamBuilder(
        stream: Firestore.instance.collection('FMS Basel').snapshots(),
        builder: (context, snapshot) {
          //check if snapshot has data
          if (!snapshot.hasData) {
            return Text("Loading..",
                style: Theme.of(context).textTheme.title); //todo loading

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
              //listview builder

              return ListView.builder(
                //document counter
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, indexDocument) {
                  //array counter
                  Map<String, dynamic> ausfallCounter =
                      snapshot.data.documents[indexDocument].data;
                  return Column(
                    children: <Widget>[
                      //titel Wochentag
                      ListTile(
                        title: Text(
                            snapshot.data.documents[indexDocument].documentID, style: Theme.of(context).textTheme.button,),
                      ),
                      ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: ausfallCounter.length,
                        itemBuilder: (context, index) {
                          List<String> ausfall = List.from(snapshot.data
                              .documents[indexDocument].data[index.toString()]);

                          return Card(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  ausfall[0], //first element from array
                                  style: Theme.of(context).textTheme.subhead,
                                ),
                                Text(
                                  ausfall[1], //second element from array
                                  style: Theme.of(context).textTheme.subhead,
                                ),
                                Text(
                                  ausfall[2], //third element from array
                                  style: Theme.of(context).textTheme.subhead,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
