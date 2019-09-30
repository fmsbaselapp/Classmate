import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Classmate/shared/button.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          return Future.value(false);
        },
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Text(
                      'Willkommen',
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 10, left: 10, right: 10, bottom: 10),
                    child: Text(
                      'Lass dir deine Stundenausfälle\njetzt in der App anzeigen!',
                      style: Theme.of(context).textTheme.headline,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),

              Center(
                              child: Row(
                   mainAxisSize: MainAxisSize.min,
                  children:<Widget>[ 
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: SmallButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: const Text('Anmelden'),
                  ),
                    ),]
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
