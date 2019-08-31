import 'package:flutter/material.dart';

import '../shared/shared.dart';


class HomeScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 30, left: 10, right: 10),
            child:
          Text("angemeldet"),
          
          
          )
        ],
      ),
      bottomNavigationBar: AppBottomNav(),
    );
  }
}
