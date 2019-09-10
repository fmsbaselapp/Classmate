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
            return Text("Loading..", style: Theme.of(context).textTheme.title);

            //if snapshot has data:
          } else {
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                List<int> doc = snapshot.data.documents[0];
                //Map<String, dynamic> ausfallCounter1 = snapshot.data.data;
                return Text(doc.toString());
                /*Column(
                  children: <Widget>[
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: ausfallCounter1.length,
                      itemBuilder: (context, index) {
                        List<String> ausfall =
                            List.from(snapshot.data[index.toString()]);
                        return Card(
                          child: Column(
                            children: <Widget>[
                              Text(
                                ausfall[0], //first element from array
                                style: Theme.of(context).textTheme.subtitle,
                              ),
                              Text(
                                ausfall[1], //second element from array
                                style: Theme.of(context).textTheme.subtitle,
                              ),
                              Text(
                                ausfall[2], //third element from array
                                style: Theme.of(context).textTheme.subtitle,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: ausfallCounter.length,
                      itemBuilder: (context, index) {
                        List<String> ausfall =
                            List.from(snapshot.data[index.toString()]);
                        return Card(
                          child: Column(
                            children: <Widget>[
                              Text(
                                ausfall[0], //first element from array
                                style: Theme.of(context).textTheme.subtitle,
                              ),
                              Text(
                                ausfall[1], //second element from array
                                style: Theme.of(context).textTheme.subtitle,
                              ),
                              Text(
                                ausfall[2], //third element from array
                                style: Theme.of(context).textTheme.subtitle,
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  ],
                  
                );
                */
              },
            );
          }
        },
      ),
    );
  }
}
