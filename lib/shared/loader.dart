import 'dart:async';
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
          valueColor: AlwaysStoppedAnimation(Theme.of(context).indicatorColor),
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
      backgroundColor: Theme.of(context).primaryColorDark,
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

class LoadingScreenWait extends StatefulWidget {
  @override
  _LoadingScreenWaitState createState() => _LoadingScreenWaitState();
}

class _LoadingScreenWaitState extends State<LoadingScreenWait> {
  Timer _timer;
  Widget _children = Container();

  _LoadingScreenWaitState() {
    _timer = new Timer(const Duration(milliseconds: 1000), () {
      setState(() {
        _children = Loader();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _children,
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
