import 'package:Classmate/app/locator.dart';
import 'package:Classmate/ui/views/uebersicht/uebersicht_view.dart';
import 'package:Classmate/ui/views/viewmodels.dart';
import 'package:Classmate/ui/views/calendar/calendar_view.dart';
import 'package:Classmate/ui/views/faecher/faecher_view.dart';
import 'package:Classmate/ui/views/noten/noten_view.dart';
import 'package:Classmate/ui/views/settings/settings_view.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  Widget getViewForIndex(int index) {
    switch (index) {
      case 0:
        return UebersichtView();
      case 1:
        return CalendarView();
      case 2:
        return NotenView();
      case 3:
        return FaecherView();
      case 4:
        return SettingsView();
      default:
        return UebersichtView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) => WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: PageTransitionSwitcher(
            duration: const Duration(milliseconds: 300),
            reverse: model.reverse,
            transitionBuilder: (
              Widget child,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) {
              return SharedAxisTransition(
                fillColor: Theme.of(context).scaffoldBackgroundColor,
                child: child,
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                transitionType: SharedAxisTransitionType.horizontal,
              );
            },
            child: getViewForIndex(model.currentIndex),
          ),
          bottomNavigationBar: CustomBottomNavBar(
            model: model,
            children: [
              Icon(Icons.home_rounded),
              Icon(Icons.today_rounded),
              Icon(Icons.timeline_rounded),
              Icon(Icons.table_rows_rounded),
              Icon(Icons.settings_rounded),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => locator<HomeViewModel>(),
    );
  }
}

class CustomBottomNavBar extends StatelessWidget {
  CustomBottomNavBar({
    @required this.children,
    this.onChange,
    this.model,
  });

  final List<Widget> children;
  final HomeViewModel model;

  final Function(int) onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(16, 16, 16, 1),
      child: SafeArea(
        child: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: children.map((item) {
              int _index = children.indexOf(item);
              return GestureDetector(
                onTap: () {
                  model.setIndex(_index);
                  print(model.currentIndex);
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  width: model.currentIndex == _index
                      ? MediaQuery.of(context).size.width / children.length + 20
                      : 50,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  margin: EdgeInsets.only(top: 10, bottom: 5),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: model.currentIndex == _index
                          ? Colors.white.withOpacity(0.3)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      item,
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
