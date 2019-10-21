import 'package:Classmate/screens/screens.dart';
import 'package:Classmate/services/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:firebase_analytics/observer.dart';
//import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

void main() {
  ConnectionStatusSingleton connectionStatus =
      ConnectionStatusSingleton.getInstance();
  connectionStatus.initialize();
  runApp(Classmate());
}

class Classmate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<FirebaseUser>.value(stream: AuthService().user),
        StreamProvider<Report>.value(stream: Global.reportRef.documentStream),
      ],
      child: Theme(
        data: ThemeData(
          primaryColor: Colors.black,
          accentColor: Colors.black,
          hintColor: Colors.grey,
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
        ),
        child: PlatformApp(
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
          /*
          // Firebase Analytics
          navigatorObservers: [
            FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
          ],
*/
          // Theme
          android: (_) => MaterialAppData(),

          ios: (_) => CupertinoAppData(),
        ),
      ),
    );
  }
}
