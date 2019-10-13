import 'package:Classmate/shared/appBar.dart';
import 'package:Classmate/shared/shared.dart';
import 'package:flutter/material.dart';

class EdubsAngebote extends StatelessWidget {
  const EdubsAngebote({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
            return Scaffold(
              appBar: ClassmateAppBar(
                height: 130,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RoundButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: 30,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 40),
                    child: Text(
                      'Edubs Angebote',
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                ],
              ),
              body: ListView(
                children: <Widget>[
                  LableFettExtended(text: 'Du kannst dir Produkte von Office kostenfrei auf deinen Computer laden.',)
                 
                ],
              ),
            );
          }
      
  }
