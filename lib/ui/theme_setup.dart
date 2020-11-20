import 'package:flutter/material.dart';

List<ThemeData> getThemes() {
  return [
    ///LIGHT THEME
    ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Color(0xfffcfcfc),
      backgroundColor: Color(0xfffcfcfc),
      primaryColorLight: Colors.black,
      accentColor: Color(0xffffffff),
      highlightColor: Color(0xfff7f7f7),
      indicatorColor: Color(0xffffffff),
      textTheme: TextTheme(
        //Titel
        headline1: TextStyle(
          fontFamily: "Maax",
          fontWeight: FontWeight.w700,
          fontSize: 40,
          color: Colors.black,
        ),
        //Untertitel
        headline2: TextStyle(
            fontFamily: "Maax",
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Colors.black),
        //Body Weiss
        bodyText1: TextStyle(
          fontFamily: "Maax",
          fontWeight: FontWeight.w500,
          fontSize: 15,
          color: Colors.black,
        ),
        //Body Grau
        bodyText2: TextStyle(
          fontFamily: "Maax",
          fontWeight: FontWeight.w500,
          fontSize: 15,
          color: Color(0xff999999),
        ),
      ),
    ),

    ///DARK THEME
    ThemeData(
      brightness: Brightness.dark,
      backgroundColor: Colors.black,
      scaffoldBackgroundColor: Colors.black,
      primaryColorLight: Colors.white,
      accentColor: Color.fromRGBO(23, 23, 23, 1),
      highlightColor: Color.fromRGBO(42, 42, 42, 1),
      indicatorColor: Color.fromRGBO(64, 64, 64, 1),
      textTheme: TextTheme(
        //Titel
        headline1: TextStyle(
          fontFamily: "MaaxBold",
          fontWeight: FontWeight.w700,
          fontSize: 40,
          color: Colors.white,
        ),
        //Untertitel
        headline2: TextStyle(
            fontFamily: "MaaxBold",
            fontWeight: FontWeight.w700,
            fontSize: 20,
            //letterSpacing: 1,
            color: Colors.white),
        //Body Weiss
        bodyText1: TextStyle(
          fontFamily: "Maax",
          fontWeight: FontWeight.w500,
          fontSize: 15,
          color: Colors.white,
        ),
        //Body Grau
        bodyText2: TextStyle(
          fontFamily: "Maax",
          fontWeight: FontWeight.w500,
          fontSize: 15,
          color: Color.fromRGBO(153, 153, 153, 1),
        ),
      ),
    ),
  ];
}
