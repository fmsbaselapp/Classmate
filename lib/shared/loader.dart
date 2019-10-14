import 'package:Classmate/shared/shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
//import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 15,
      width: 15,
      child: PlatformCircularProgressIndicator(
        android: (_) => MaterialProgressIndicatorData(
          valueColor: AlwaysStoppedAnimation(Colors.black),
        ),
        ios: (_) => CupertinoProgressIndicatorData(radius: 20),
      ),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Loader(),
          Container(
            height: 80,
          )
        ],
      ),
    );
  }
}

/*PlatformCircularProgressIndicator(
            android: (_) => MaterialProgressIndicatorData(
                valueColor: AlwaysStoppedAnimation(Colors.black)),
            ios: (_) => CupertinoProgressIndicatorData(radius: 20)));
            */

/*
SizedBox(
          child: PlatformCircularProgressIndicator(
 android: (_) => MaterialProgressIndicatorData(valueColor: AlwaysStoppedAnimation(Colors.black),),
  ios: (_)=> CupertinoProgressIndicatorData(),
),
    );
    */
