import 'package:flutter/material.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      child: MaterialApp(
        // Firebase Analytics
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
        ],

        // Theme
        theme: ThemeData(
          bottomAppBarTheme: BottomAppBarTheme(
            color: Colors.black,
          ),
          brightness: Brightness.light,
          textTheme: TextTheme(
            title: TextStyle(fontSize: 35, fontFamily: 'MaaxBold'),
            headline: TextStyle(fontSize: 17, fontFamily: 'MaaxMedium'),
            subhead: TextStyle(fontSize: 15, fontFamily: 'MaaxMedium'),
            button: TextStyle(fontSize: 21, fontFamily: 'MaaxBold')
          ),
          buttonTheme: ButtonThemeData(
            
            
          ),
        ),

        // Named Routes
        routes: {
          '/': (context) => LandingScreen(),
          '/login': (context) => LoginScreen(),
          //'/verifizieren': (context) => VerifizierenScreen(),
          '/home': (context) => HomeScreen(),
          '/profile': (context) => ProfileScreen(),
          '/about': (context) => AboutScreen(),
        },
      ),
    );
  }
}
