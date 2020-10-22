import 'package:Classmate/Home/home_view.dart';
import 'package:Classmate/ui/theme_setup.dart';
import 'package:flutter/material.dart';
import 'package:stacked_themes/stacked_themes.dart';

Future main() async {
  await ThemeManager.initialise();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      themes: getThemes(),
      //statusBarColorBuilder: (theme) => theme.accentColor,
      builder: (context, regularTheme, darkTheme, themeMode) => MaterialApp(
        title: 'Classmate',
        theme: regularTheme,
        darkTheme: darkTheme,
        themeMode: themeMode,
        home: Home_view(),
      ),
    );
  }
}
