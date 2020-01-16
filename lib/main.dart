import 'package:Classmate/screens/screens.dart';
import 'package:Classmate/services/services.dart';
import 'package:Classmate/services/theme.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

//DARK or LIGHT MODE
  SharedPreferences.getInstance().then(
    (prefs) {
      var darkModeOn = prefs.getBool('darkMode') ?? true;
      runApp(
        ChangeNotifierProvider<ThemeNotifier>(
          create: (_) => ThemeNotifier(darkModeOn ? darkTheme : lightTheme),
          child: Classmate(),
        ),
      );
      if (darkModeOn) {
        bool value = true;
        setStatusBarTextColor(value);
        //setAppIcon(value);
      } else {
        bool value = false;
        setStatusBarTextColor(value);
        //setAppIcon(value);
      }
    },
  );
}

FirebaseAnalytics analytics = FirebaseAnalytics();

class Classmate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MultiProvider(
      providers: [
        StreamProvider<FirebaseUser>.value(value: AuthService().user),
        StreamProvider<Report>.value(
          value: Global.reportRef.documentStream,
          initialData: Report(schule: 'lädt...'),
        ),
      ],
      child: MaterialApp(
        theme: themeNotifier.getTheme(),

        // Named Routes
        //onUnknownRoute: null, //TODO
        routes: {
          '/': (context) => WelcomeScreen(),
          '/login': (context) => LoginScreen(),
          '/home': (context) => HomeScreen(),
          '/settings': (context) => SettingsScreen(),
          '/schoolSelect': (context) => SchoolSelectScreen(),
          '/signOut': (context) => SignOut(),
        },

        // Firebase Analytics
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
        ],
      ),
    );
  }
}
