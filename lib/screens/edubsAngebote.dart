import 'package:Classmate/shared/appBar.dart';
import 'package:Classmate/shared/shared.dart';
import 'package:flutter/material.dart';

class EdubsAngebote extends StatelessWidget {
  const EdubsAngebote({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
            return Scaffold(
              appBar: ClassmateAppBar(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: RoundButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        size: 30,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Text(
                          'Angebote',overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.title,
                        ),
                      ),
                    ),
                  )
                ],
                height: 80,
              ),
              body: ListView(
                children: <Widget>[
                  LableFettExtended(text: 'Du kannst dir Produkte von Office kostenfrei auf deinen Computer laden.',)
                 
                ],
              ),
            );
          }
      
  }
