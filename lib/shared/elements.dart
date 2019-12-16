import 'package:flutter/material.dart';

class LableFettExtended extends StatelessWidget {
  LableFettExtended({@required this.text, this.margin});

  String text;
  var margin;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
        color: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(15.0)),
        elevation: 10,
        child: Padding(
          padding: EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
          child: Text(
            text,
            style: Theme.of(context).textTheme.button,
          ),
        ),
      ),
    );
  }
}

class LableFettExtendedSansPadding extends StatelessWidget {
  LableFettExtendedSansPadding({@required this.text, this.margin});

  String text;
  var margin;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(15.0)),
        elevation: 10,
        child: Padding(
          padding: EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
          child: Text(
            text,
            style: Theme.of(context).textTheme.button,
          ),
        ),
      ),
    );
  }
}

class LableHome extends StatelessWidget {
  LableHome({@required this.text, this.margin});

  String text;
  var margin;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        margin: EdgeInsets.only(left: 10, right: 10, top: 0),
        color: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(15.0)),
        elevation: 10,
        child: Padding(
          padding: EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
          child: Text(
            text,
            style: Theme.of(context).textTheme.button,
          ),
        ),
      ),
    );
  }
}

class Lable extends StatelessWidget {
 Lable({@required this.child,});

 
  Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(15.0)),
        elevation: 10,
        child: Padding(
          padding: EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
          child: child
        ),
      ),
    );
  }
}