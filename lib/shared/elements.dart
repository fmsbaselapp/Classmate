import 'package:flutter/material.dart';
import 'package:flutter_dynamic_icon/flutter_dynamic_icon.dart';

import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:Classmate/services/services.dart';

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

class LableDarkMode extends StatefulWidget {
  LableDarkMode({@required this.text, this.margin});

  String text;
  EdgeInsetsGeometry margin;

  @override
  _LableDarkModeState createState() => _LableDarkModeState();
}

class _LableDarkModeState extends State<LableDarkMode> {
  bool _darkTheme;

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    _darkTheme = (themeNotifier.getTheme() == darkTheme);
    return SizedBox(
      width: double.infinity,
      child: Card(
        margin: widget.margin,
        color: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(15.0)),
        elevation: 5,
        child: InkWell(
          borderRadius: BorderRadius.circular(15.0),
          onTap: () async {
            setState(() {
              _darkTheme = _darkTheme;
            });

            onThemeChanged(!_darkTheme, themeNotifier);
            try {
              if (await FlutterDynamicIcon.supportsAlternateIcons) {
                if (_darkTheme) {
                  await FlutterDynamicIcon.setAlternateIconName("dark");
                  print("App icon change successful");
                  return;
                } else {
                  await FlutterDynamicIcon.setAlternateIconName("light");
                  print("App icon change successful");
                  return;
                }
              }
            } on PlatformException {} catch (e) {}
            print("Failed to change app icon");
          },
          child: Padding(
            padding:
                EdgeInsets.only(top: 2, bottom: 2, left: 10, right: 10), //TODO
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                AnimatedDefaultTextStyle(
                  style: Theme.of(context).textTheme.button,
                  duration: Duration(milliseconds: 200),
                  child: Text(
                    widget.text,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Transform.scale(
                  scale: 1.0,
                  child: Switch.adaptive(
                    activeColor: Theme.of(context).accentColor,
                    value: _darkTheme,
                    onChanged: (val) async {
                      setState(() {
                        _darkTheme = val;
                      });
                      onThemeChanged(val, themeNotifier);
                      try {
                        if (await FlutterDynamicIcon.supportsAlternateIcons) {
                          if (_darkTheme) {
                            await FlutterDynamicIcon.setAlternateIconName(
                                "dark");
                            print("App icon change successful");
                            return;
                          } else {
                            await FlutterDynamicIcon.setAlternateIconName(
                                "light");
                            print("App icon change successful");
                            return;
                          }
                        }
                      } on PlatformException {} catch (e) {}
                      print("Failed to change app icon");
                    },
                  ),
                ),
              ],
            ),
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
