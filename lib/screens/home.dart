import 'package:Classmate/services/services.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../shared/shared.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 40, bottom: 10),
            child: SmallButton(
              onPressed: () => Navigator.pushNamed(context, '/about'),
              child: Text('Einstellungen'),
            ),
          ),
          /*SmallButton(
            child: Text('Datenbank'),
            onPressed: () {
              // This points to the collection called 'cities'
              var query = Firestore.instance.collection('cities');
              query.getDocuments().then(
                (querySnapshot) {
                  
                  
                  var data = querySnapshot.documents.map(
                    (documentSnapshot) {
                      
                      
                      print(documentSnapshot.data.map(f));
                    },
                  );
                  // get the data of all the documents into an array
                },
              );
            },
          ),*/
          StreamBuilder(
            stream: Firestore.instance
                .collection('FMS Basel')
                .document('Dienstag')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                //todo loadding

                return Text("Loading..",
                    style: Theme.of(context).textTheme.title);
              } else {
                print(snapshot.data);
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Text(
                        snapshot.data['body'],
                        style: Theme.of(context).textTheme.subtitle,
                      ),
                    );
                  },
                );
              }
            },
          ),
          SmallButton(
            child: Text('Map Test'),
            onPressed: () {

          
            },
          )
        ],
      ),
    );
  }
}
