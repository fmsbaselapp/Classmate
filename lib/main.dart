import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'services/services.dart';
import 'screens/screens.dart';
import 'package:provider/provider.dart';

void main() => runApp(Classmate());

class Classmate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<FirebaseUser>.value(stream: AuthService().user),
      ],
      child: Theme(
        data: ThemeData(
          bottomAppBarTheme: BottomAppBarTheme(
            color: Colors.black,
          ),
          brightness: Brightness.light,
          textTheme: TextTheme(
              title: TextStyle(fontSize: 35, fontFamily: 'MaaxBold'),
              headline: TextStyle(fontSize: 16, fontFamily: 'MaaxMedium'),
              subhead: TextStyle(fontSize: 15, fontFamily: 'MaaxMedium'),
              button: TextStyle(fontSize: 16, fontFamily: 'MaaxBold')),
          buttonTheme: ButtonThemeData(),
        ),
        child: PlatformApp(
          // Named Routes
          onUnknownRoute: null,//TODO
          routes: {
            //'/': (context) => LandingScreen(),
            '/': (context) => HomeScreen(),
            '/login': (context) => LoginScreen(),
            '/home': (context) => HomeScreen(),
            '/profile': (context) => ProfileScreen(),
            '/settings': (context) => SettingsScreen(),
          },
          // Firebase Analytics
          navigatorObservers: [
            FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
          ],

          // Theme
          android: (_) => MaterialAppData(),

          ios: (_) => CupertinoAppData(),
        ),
      ),
    );
  }
}
