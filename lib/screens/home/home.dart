import 'dart:async';
import 'package:Classmate/screens/screens.dart';
import 'package:Classmate/services/services.dart';
import 'package:Classmate/shared/shared.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';

//Checks if User has School
class HomeScreen extends StatelessWidget {
  final FirebaseUser user;

  HomeScreen({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Future.value(false);
      },
      child: FutureBuilder<RemoteConfig>(
        future: setupRemoteConfig(),
        builder: (BuildContext context, AsyncSnapshot<RemoteConfig> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.getBool('ForceUpdate')) {
              return FadeIn(
                child: UpdateScreen(
                  user: user,
                  force: true,
                ),
              );
            } else if (snapshot.data.getBool('Update')) {
              return FadeIn(child: UpdateScreen(user: user, force: false));
            } else
              print(snapshot.data.getAll());
            return CheckerModule(user: user);
          }

          return Scaffold(
            backgroundColor: Theme.of(context).primaryColorDark,
          );
        },
      ),
    );
  }
}

//Checkt Schule
class CheckerModule extends StatelessWidget {
  const CheckerModule({
    Key key,
    @required this.user,
  }) : super(key: key);

  final FirebaseUser user;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Global.reportRef.documentStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingScreenWait();
        } else if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return LoadingScreenWait();
          }
          if (snapshot.hasData) {
            print('hasdata');
            print(snapshot.data.schule);

            if (snapshot.data.schule == 'lädt...') {
              return LoadingScreenWait();
            } else if (snapshot.data.schule != 'keine Schule') {
              /* if (Platform.isIOS) {
                Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                    builder: (context) =>
                        ClassSelectChecker(user: user, snapshot: snapshot),
                  ),
                );
              } else {

             
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ClassSelectChecker(user: user, snapshot: snapshot),
                  ),
                );
              }*/

              return ClassSelectChecker(user: user, snapshot: snapshot);
              //Home();
            } else if (snapshot.data.schule == 'keine Schule') {
              print('SchoolSelect initialized');
              return SchoolSelectScreenFirst(user: user);
            } else if (snapshot.data.schule == null) {
              return SchoolSelectScreenFirst(user: user);
            } else {
              return LoadingScreenWait();
            }
          } else {
            return LoadingScreenWait();
          }
        } else {
          return LoadingScreenWait();
        }
      },
    );
  }
}

//Checks if User has Class
class ClassSelectChecker extends StatelessWidget {
  final FirebaseUser user;
  final AsyncSnapshot snapshot;
  const ClassSelectChecker({
    Key key,
    @required this.user,
    @required this.snapshot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (snapshot.data.klasse == 'lädt...') {
      return LoadingScreenWait();
    } else if (snapshot.data.klasse != 'keine Klasse') {
      return MessageHandler();
    } else if (snapshot.data.klasse == 'keine Klasse') {
      print('ClassSelect initialized');

      return ClassSelectScreenFirst();
    } else if (snapshot.data.klasse == null) {
      return ClassSelectScreenFirst();
    } else {
      return LoadingScreenWait();
    }
  }
}

//REMOTE CONFIG
Future<RemoteConfig> setupRemoteConfig() async {
  final RemoteConfig remoteConfig = await RemoteConfig.instance;
  // Enable developer mode to relax fetch throttling
  remoteConfig.setConfigSettings(
      RemoteConfigSettings(debugMode: true)); //TODO: Disable Debug mode
  remoteConfig.setDefaults(<String, dynamic>{
    'Update': 'false',
    'ForceUpdate': 'false',
  });
  await remoteConfig.fetch(expiration: const Duration(hours: 0));
  await remoteConfig.activateFetched();
  return remoteConfig;
}

//HOME
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  final List<String> _tabs = ['Ausfälle', 'Mitteilungen'];
  TabController _controller;

  /// Main Rate my app instance.
  RateMyApp _rateMyApp = RateMyApp(
    preferencesPrefix: 'rateClassmate_',
    minDays: 7,
    minLaunches: 7,
    remindDays: 10,
    remindLaunches: 10,
    appStoreIdentifier: '1483540166',
    googlePlayIdentifier: 'ch.classmate.app',
  );

  void initState() {
    super.initState();

    _rateMyApp.init().then(
      (_) {
        if (_rateMyApp.shouldOpenDialog) {
          _rateMyApp.showStarRateDialog(
            context,
            title: 'Gefällt dir Classmate?',
            message:
                'Tippe einen Stern um im PlayStore eine Bewertung abzugeben. :)',
            onRatingChanged: (stars) {
              return [
                FlatButton(
                  child: Text('Bewerten!'),
                  onPressed: () async {
                    print('Danke für die ' +
                        (stars == null ? '0' : stars.round().toString()) +
                        ' Sterne!');
                   
                    // You can handle the result as you want (for instance if the user puts 1 star then open your contact page, if he puts more then open the store page, etc...).
                    await _rateMyApp.callEvent(RateMyAppEventType
                        .rateButtonPressed); // This allows to mimic the behavior of the default "Rate" button. See "Advanced > Broadcasting events" for more information.

                    Navigator.pop(context);
                  },
                ),
              ];
            },
            ignoreIOS: false,
            dialogStyle: DialogStyle(
              titleAlign: TextAlign.center,
              messageAlign: TextAlign.center,
              messagePadding: EdgeInsets.only(bottom: 20),
            ),
          );
        }
      },
    );
    _controller = new TabController(length: 2, vsync: this);
    _controller.addListener(_handleSelected);
  }

  void _handleSelected() {
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool _darkTheme;
  @override
  Widget build(BuildContext context) {
    Report report = Provider.of<Report>(context);
    return WillPopScope(
      onWillPop: () async {
        return Future.value(false);
      },
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Theme.of(context).primaryColorDark,
          appBar: ClassmateAppBar(
            children: <Widget>[
              Text(
                _tabs[_controller.index],
                style: Theme.of(context).textTheme.title,
              ),
              RoundButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/settings');
                },
                child: Icon(
                  Icons.settings,
                  size: 30,
                ),
              ),
            ],
            height: 60,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
          body: HomeBody(controller: _controller, report: report),
        ),
      ),
    );
  }
}
