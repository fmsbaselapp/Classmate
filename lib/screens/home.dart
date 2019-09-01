import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../shared/shared.dart';

class HomeScreen extends StatelessWidget {
  Widget _buildList(BuildContext context, DocumentSnapshot document) {
    return Card(
      child: Text(
        document['body'],
        style: Theme.of(context).textTheme.subtitle,
      ),
      /*  subtitle: Text(
        document['body'],
        style: TextStyle(color: Colors.black),
        */
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SmallButton(
            onPressed: () => Navigator.pushNamed(context, '/about'),
            child: Text('Einstellungen'),
          ),
          StreamBuilder(
            stream: Firestore.instance.collection('posts').document('').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                //todo loadding
                return Text("Loading..",
                    style: Theme.of(context).textTheme.title);
              } 
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                 
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return _buildList(context, snapshot.data.documents[index]);
                  },
                );
              
            },
          ),
        ],
      ),
    );
  }
}
