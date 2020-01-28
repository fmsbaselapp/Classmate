import 'dart:async';
import 'dart:io';

import 'package:Classmate/screens/screens.dart';
import 'package:Classmate/services/services.dart';
import 'package:Classmate/shared/shared.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';

const double paddingSite = 10;

//Checker
class HomeScreen extends StatelessWidget {
  final FirebaseUser user;

  HomeScreen({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Future.value(false);
      },
      child: StreamBuilder(
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
                return Home();
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
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  final List<String> _tabs = ['Ausfälle', 'Mitteilungen'];
  TabController _controller;

  /// Main Rate my app instance.
  RateMyApp _rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
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
                    print('Thanks for the ' +
                        (stars == null ? '0' : stars.round().toString()) +
                        ' star(s) !');
                    //TODO
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

    return DefaultTabController(
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
        body: MessageHandler(controller: _controller, report: report),
      ),
    );
  }
}

class MessageHandler extends StatefulWidget {
  MessageHandler({
    Key key,
    @required TabController controller,
    @required this.report,
  })  : _controller = controller,
        super(key: key);
  final TabController _controller;
  final Report report;
  @override
  _MessageHandlerState createState() => _MessageHandlerState();
}

class _MessageHandlerState extends State<MessageHandler> {
  final Firestore _db = Firestore.instance;
  final FirebaseMessaging _notification = FirebaseMessaging();
  StreamSubscription iosSubscription;
  @override
  void initState() {
    super.initState();

    if (Platform.isIOS) {
      iosSubscription = _notification.onIosSettingsRegistered.listen((data) {
        _safeDeviceToken();
      });
      _notification.requestNotificationPermissions(
        IosNotificationSettings(),
      );
    } else {
      _safeDeviceToken();
    }

    _notification.subscribeToTopic('3C');

    _notification.configure(onMessage: (Map<String, dynamic> message) async {
      print("onMessage: $message");
      final snackbar = SnackBar(
        content: Text(
          message['notification']['title'],
        ),
        action: SnackBarAction(
          label: 'Go',
          onPressed: () => null,
        ),
      );

      Scaffold.of(context).showSnackBar(snackbar);
    }, onResume: (Map<String, dynamic> message) async {
      print("onResume: $message");
    }, onLaunch: (Map<String, dynamic> message) async {
      print("onLaunch: $message");
    });
  }

  @override
  void dispose() {
    iosSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: HomeBody(controller: widget._controller, report: widget.report),
    );
  }

  _safeDeviceToken() async {
    FirebaseUser user = await AuthService().getUser;
    String fmcToken = await _notification.getToken();

    if (fmcToken != null) {
      DocumentReference tokenRef = _db.collection('Nutzer').document(user.uid);
      print('habe Token');
      await tokenRef.updateData(
        {
          'fmcToken': {
            'token': fmcToken,
            'erstelltAm': FieldValue.serverTimestamp(),
            'platform': Platform.operatingSystem,
          }
        },
      );
    }
  }
}
