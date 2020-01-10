import 'dart:async';

import 'package:Classmate/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbar_text_color/flutter_statusbar_text_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier with ChangeNotifier {
  ThemeData _themeData;

  ThemeNotifier(this._themeData);

  getTheme() => _themeData;

  setTheme(ThemeData themeData) async {
    _themeData = themeData;
    notifyListeners();
  }
}

void onThemeChanged(bool value, ThemeNotifier themeNotifier) async {
  if (value) {
    themeNotifier.setTheme(darkTheme);
    setStatusBarTextColor(value);
  } else {
    themeNotifier.setTheme(lightTheme);
    setStatusBarTextColor(value);
  }

  var prefs = await SharedPreferences.getInstance();
  prefs.setBool('darkMode', value);
}


Timer _timer;

void setStatusBarTextColor(value) {
  _timer?.cancel();

  _timer = Timer(Duration(milliseconds: 200), () async {
    try {
      if (value) {
        await FlutterStatusbarTextColor.setTextColor(
            FlutterStatusbarTextColor.light);
            
      } else {
        await FlutterStatusbarTextColor.setTextColor(
            FlutterStatusbarTextColor.dark);
      }
    } catch (_) {
      print('set status bar text color failed');
    }
  });
}

final lightTheme = ThemeData(
  primaryColorBrightness: Brightness.dark,
  primaryColor: Colors.white,
  primaryColorDark: Colors.white,
  accentColor: Colors.black,
  hintColor: Colors.grey,
  cardColor: Colors.white,
  indicatorColor: Colors.black,
  tabBarTheme: TabBarTheme(labelColor: Colors.black),
  toggleableActiveColor: Colors.black,
  bottomAppBarTheme: BottomAppBarTheme(
    color: Colors.black,
  ),
  brightness: Brightness.light,
  textTheme: TextTheme(
    title: TextStyle(fontSize: 35, fontFamily: 'MaaxBold'),
    headline: TextStyle(fontSize: 16, fontFamily: 'MaaxMedium'),
    subhead: TextStyle(fontSize: 15, fontFamily: 'MaaxMedium'),
    button: TextStyle(fontSize: 16, fontFamily: 'MaaxBold'),
    body2: TextStyle(
      fontSize: 16,
      fontFamily: 'MaaxBold',
    ),
  ),
  buttonTheme: ButtonThemeData(),
);

final darkTheme = ThemeData(
  primaryColorBrightness: Brightness.light,
  accentColorBrightness: Brightness.light,
  primaryColor: Color(0xff454545),
  primaryColorDark: Colors.black,
  accentColor: Color(0xff868686),
  hintColor: Color(0xff868686),
  cardColor: Color(0xff454545),
  indicatorColor: Colors.white,
  tabBarTheme: TabBarTheme(labelColor: Color(0xff454545)),
  toggleableActiveColor: Colors.grey[500],
  bottomAppBarTheme: BottomAppBarTheme(
    color: Colors.black,
  ),
  brightness: Brightness.dark,
  textTheme: TextTheme(
    title: TextStyle(fontSize: 35, fontFamily: 'MaaxBold'),
    headline: TextStyle(fontSize: 16, fontFamily: 'MaaxMedium'),
    subhead: TextStyle(fontSize: 15, fontFamily: 'MaaxMedium'),
    button: TextStyle(fontSize: 16, fontFamily: 'MaaxBold'),
    body2: TextStyle(
      fontSize: 16,
      fontFamily: 'MaaxBold',
    ),
  ),
  buttonTheme: ButtonThemeData(),
);
