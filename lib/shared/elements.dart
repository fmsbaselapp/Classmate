import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

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
  EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        margin: margin,
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

/*
class LableDarkMode extends StatefulWidget {
  LableDarkMode({@required this.text, this.margin});

  String text;
  EdgeInsetsGeometry margin;

  @override
  _LableDarkModeState createState() => _LableDarkModeState();
}


class _LableDarkModeState extends State<LableDarkMode> {
  bool isSwitched = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        margin: widget.margin,
        color: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(15.0)),
        elevation: 10,
        child: Padding(
          padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                widget.text,
                style: Theme.of(context).textTheme.button,
              ),
              Transform.scale(
                scale: 1.0,
                child: PlatformSwitch(
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                    });
                  },
                  value: isSwitched,
                  android: (_) => MaterialSwitchData(
                    activeTrackColor: Colors.lightGreenAccent,
                    activeColor: Colors.green,
                  ),
                  ios: (_) => CupertinoSwitchData(
                    activeColor: Theme.of(context).toggleableActiveColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
} */

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
  Lable({
    @required this.child,
  });

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
            child: child),
      ),
    );
  }
}
