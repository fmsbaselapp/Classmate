import 'package:Classmate/screens/screens.dart';
import 'package:Classmate/services/services.dart';
import 'package:Classmate/shared/shared.dart';
import 'package:connectivity_widget/connectivity_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeBody extends StatefulWidget {
  HomeBody({
    Key key,
    @required TabController controller,
    @required this.report,
  })  : _controller = controller,
        super(key: key);

  final TabController _controller;
  final Report report;

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  bool _darkTheme;

  @override
  Widget build(BuildContext context) {
    Report report = Provider.of<Report>(context);
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    _darkTheme = (themeNotifier.getTheme() == lightTheme);
    SharedPreferences.getInstance().then((prefs) {
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
              controller: widget._controller,
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
                            color: widget._controller.index == 0
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
                          color: widget._controller.index == 1
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
            controller: widget._controller,
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
                        onPressed: () async {
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
                        onPressed: () async {
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
