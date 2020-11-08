import 'package:Classmate/models/test.dart';
import 'package:flutter/material.dart';

class TestBig extends StatelessWidget {
  const TestBig({
    @required this.test,
    Key key,
  }) : super(key: key);

  final Test test;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
      decoration: BoxDecoration(
        color: Color.fromRGBO(210, 48, 47, 1),
        borderRadius: BorderRadius.circular(15.00),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                test.titel,
                style: Theme.of(context).textTheme.headline2,
              ),
              Text(
                test.fach + ' | ' + test.datum,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
          Container(
            height: 40,
            width: 40,
            color: Colors.blue,
          )
        ],
      ),
    );
  }
}

class TestSmall extends StatelessWidget {
  const TestSmall({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
      decoration: BoxDecoration(
        color: Color(0xffc23f38),
        borderRadius: BorderRadius.circular(15.00),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Deutsch Aufsatz',
                style: Theme.of(context).textTheme.headline2,
              ),
              Text(
                'Biologie | Freitag, 31 Januar',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
          Container(
            height: 40,
            width: 40,
            color: Colors.blue,
          )
        ],
      ),
    );
  }
}
