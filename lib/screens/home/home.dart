import 'package:Classmate/screens/screens.dart';
import 'package:Classmate/services/services.dart';
import 'package:Classmate/shared/shared.dart';
import 'package:connectivity_widget/connectivity_widget.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

class MyTabs {
  final String title;
  MyTabs({this.title});
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
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    _darkTheme = (themeNotifier.getTheme() == darkTheme);
    SharedPreferences.getInstance().then((prefs) {
      var darkModeOn = prefs.getBool('darkMode');
      FirebaseAnalytics().setUserProperty(name: "Schule", value: report.schule);
    });
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
        body: HomeBody(controller: _controller, report: report),
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  HomeBody({
    Key key,
    @required TabController controller,
    @required this.report,
  })  : _controller = controller,
        super(key: key);

  final TabController _controller;
  final Report report;

  bool _darkTheme;
  @override
  Widget build(BuildContext context) {
    Report report = Provider.of<Report>(context);
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    _darkTheme = (themeNotifier.getTheme() == darkTheme);
    SharedPreferences.getInstance().then((prefs) {
      var darkModeOn = prefs.getBool('darkMode');
      if (prefs.getBool('darkMode') == null) {
       
        _showBottomSheet(context);
      }
    });
    return Column(
      children: <Widget>[
        Padding(
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),

          //Tabbar Container
          child: Container(
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
              border: Border.all(
                  color: Theme.of(context).primaryColorDark, width: 3),
            ),

            //Tabbar
            child: TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              controller: _controller,
              indicator: new BubbleTabIndicator(
                insets: EdgeInsets.only(left: 0, right: 0, top: 0),
                indicatorHeight: 24,
                indicatorColor: Theme.of(context).tabBarTheme.labelColor,
                tabBarIndicatorSize: TabBarIndicatorSize.tab,
              ),
              tabs: <Widget>[
                Tab(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Text(
                        'Ausfälle',
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.subhead.copyWith(
                            color: _controller.index == 0
                                ? Colors.white
                                : Theme.of(context).indicatorColor),
                      ),
                    ),
                  ),
                ),
                Tab(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: Text(
                      'Mitteilungen',
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.subhead.copyWith(
                          color: _controller.index == 1
                              ? Colors.white
                              : Theme.of(context).indicatorColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        //Tabbarview
        Flexible(
          child: TabBarView(
            dragStartBehavior: DragStartBehavior.down,
            controller: _controller,
            children: <Widget>[
              StreamBuilder(
                initialData: true,
                stream: ConnectivityUtils.instance.isPhoneConnectedStream,
                builder: (BuildContext context, AsyncSnapshot connection) {
                  if (connection.data) {
                    print('online');
                    return AusfaelleTab(
                      report: report,
                    );
                  } else {
                    print('offline');
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.signal_wifi_off,
                          color: Theme.of(context).indicatorColor,
                          size: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 80, top: 20),
                          child: Text(
                            'Kein Internet?',
                            style: Theme.of(context).textTheme.subtitle,
                          ),
                        )
                      ],
                    );
                  }
                },
              ),
              StreamBuilder(
                initialData: true,
                stream: ConnectivityUtils.instance.isPhoneConnectedStream,
                builder: (BuildContext context, AsyncSnapshot connection) {
                  if (connection.data) {
                    print('online');
                    return MitteilungenTab(
                      report: report,
                    );
                  } else {
                    print('offline');
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.signal_wifi_off,
                          color: Theme.of(context).indicatorColor,
                          size: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 80, top: 20),
                          child: Text(
                            'Kein Internet?',
                            style: Theme.of(context).textTheme.subtitle,
                          ),
                        )
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showBottomSheet(context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    _darkTheme = (themeNotifier.getTheme() == darkTheme);
    var _theme = themeNotifier.getTheme();
    Scaffold.of(context).showBottomSheet(
      (context) => SizedBox(
        height: 220,
        width: double.infinity,
        child: Card(
          margin: EdgeInsets.all(0),
          color: Theme.of(context).primaryColorDark,
          elevation: 30,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 10),
                child: Text(
                  'Hallo',
                  style: Theme.of(context).textTheme.title,
                ),
              ),
              Text(
                'Wähle das Thema der App aus:',
                style: Theme.of(context).textTheme.subtitle,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 5),
                      child: SmallButtonLight(
                        child: Text('Hell'),
                        onPressed: () {
                          if (_theme == darkTheme) {
                            onThemeChanged(false, themeNotifier);

                            Navigator.pop(context);
                          } else {
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10, left: 5),
                      child: SmallButtonDark(
                        child: Text('Dunkel'),
                        onPressed: () {
                          if (_theme == lightTheme) {
                            onThemeChanged(true, themeNotifier);
                            Navigator.pop(context);
                          } else {
                            Navigator.pop(context);
                          }
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
