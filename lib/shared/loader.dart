import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 15,
        width: 15,
        child: Icon(Icons.exposure_zero));
        
        /*PlatformCircularProgressIndicator(
            android: (_) => MaterialProgressIndicatorData(
                valueColor: AlwaysStoppedAnimation(Colors.black)),
            ios: (_) => CupertinoProgressIndicatorData(radius: 20)));
            */
  }
}

        
        /*PlatformCircularProgressIndicator(
            android: (_) => MaterialProgressIndicatorData(
                valueColor: AlwaysStoppedAnimation(Colors.black)),
            ios: (_) => CupertinoProgressIndicatorData(radius: 20)));
            */

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 15,
        width: 15,
        child: Icon(Icons.exposure_zero));
        
        /*PlatformCircularProgressIndicator(
            android: (_) => MaterialProgressIndicatorData(
                valueColor: AlwaysStoppedAnimation(Colors.black)),
            ios: (_) => CupertinoProgressIndicatorData(radius: 20)));
            */
  }
}
/*
SizedBox(
          child: PlatformCircularProgressIndicator(
 android: (_) => MaterialProgressIndicatorData(valueColor: AlwaysStoppedAnimation(Colors.black),),
  ios: (_)=> CupertinoProgressIndicatorData(),
),
    );
    */
