import 'package:flutter/material.dart';

class Test_Big extends StatelessWidget {
  const Test_Big({
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

class Test_Small extends StatelessWidget {
  const Test_Small({
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
