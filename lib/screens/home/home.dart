import 'package:Classmate/screens/screens.dart';
import 'package:Classmate/services/services.dart';
import 'package:Classmate/shared/shared.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';

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
          return LoadingScreen();
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
          return LoadingScreen();
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
  final List<String> _tabs = [
    'Ausfälle',
    'Neuigkeiten',
    'Anlässe'
  ];
  String _homeTitle;
  TabController _controller;
  void initState() {
    super.initState();
    _controller = new TabController(length: 3, vsync: this);
    _homeTitle = _tabs[0];
    _controller.addListener(_handleSelected);
  }

  void _handleSelected() {
    setState(() {
      _homeTitle = _tabs[_controller.index];
    });
  }

  @override
  Widget build(BuildContext context) {
    Report report = Provider.of<Report>(context);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
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
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                controller: _controller,
                indicator: new BubbleTabIndicator(
                  indicatorHeight: 10.0,
                  indicatorColor: Colors.black,
                  tabBarIndicatorSize: TabBarIndicatorSize.tab,
                ),
                tabs: <Widget>[
                  Tab(
                    child: Container(),
                  ),
                  Tab(
                    child: Container(),
                  ),
                  Tab(
                    child: Container(),
                  ),
                ],
              ),
            ),
            Flexible(
              child: TabBarView(
                controller: _controller,
                children: <Widget>[
                  AusfaelleTab(
                    report: report,
                  ),
                  NeuigkeitenTab(report: report),
                  AnlaesseTab(
                    report: report,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
