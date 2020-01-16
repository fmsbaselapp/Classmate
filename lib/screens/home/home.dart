import 'dart:async';

import 'package:Classmate/screens/screens.dart';
import 'package:Classmate/services/services.dart';
import 'package:Classmate/shared/shared.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:rate_my_app/rate_my_app.dart';

const double paddingSite = 10;

//Checker
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Global.reportRef.documentStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);

          return LoadingScreenWait();
        }
        if (snapshot.hasData) {
          print('hasdata');
          print(snapshot.data);
          Report report = snapshot.data;
          if (report.schule == '') {
            return SchoolSelectScreenFirst();
          } else {
            return Home();
          }
        } else {
          return LoadingScreenWait();
        }
      },
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
  String _homeTitle;
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
    _homeTitle = _tabs[0];
    _controller.addListener(_handleSelected);
  }

  void _handleSelected() {
    setState(() {
      _homeTitle = _tabs[_controller.index];
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Report report = Provider.of<Report>(context);
    FirebaseAnalytics().setUserProperty(name: "Schule", value: report.schule);

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
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 10, right: 10),

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
                  AusfaelleTab(
                    report: report,
                  ),
                  MitteilungenTab(
                    report: report,
                  ),
                
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
