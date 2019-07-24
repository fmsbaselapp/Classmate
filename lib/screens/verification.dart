import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: Container(
          child: Center(
            child: Column(
              children: <Widget>[Text('Verification')],
            ),
          ),
        ),
      ),
    );
  }
}
