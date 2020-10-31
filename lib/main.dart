import 'package:Classmate/app/locator.dart';
import 'package:Classmate/app/router.gr.dart' as auto_router;
import 'package:Classmate/ui/theme_setup.dart';
import 'package:flutter/material.dart';
import 'package:stacked_themes/stacked_themes.dart';
import 'package:get/get.dart';

Future main() async {
  await ThemeManager.initialise();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      themes: getThemes(),
      //statusBarColorBuilder: (theme) => theme.accentColor,
      builder: (context, regularTheme, darkTheme, themeMode) => GetMaterialApp(
        title: 'Classmate',
        theme: getThemes().first,
        darkTheme: getThemes().last,
        themeMode: themeMode,
        //Todo: initial
        initialRoute: auto_router.Routes.startupView,
        onGenerateRoute: auto_router.Router().onGenerateRoute,
      ),
    );
  }
}
