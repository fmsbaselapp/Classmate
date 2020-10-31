import 'package:Classmate/app/locator.dart';
import 'package:Classmate/viewmodels/viewmodels.dart';
import 'package:Classmate/ui/views/calendar_view.dart';
import 'package:Classmate/ui/views/faecher_view.dart';
import 'package:Classmate/ui/views/noten_view.dart';
import 'package:Classmate/ui/views/settings_view.dart';
import 'package:Classmate/ui/views/uebersicht_view.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
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
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color.fromRGBO(16, 16, 16, 1),
          currentIndex: model.currentIndex,
          onTap: model.setIndex,
          items: [
            BottomNavigationBarItem(
              title: Text('Übersicht'),
              icon: Icon(Icons.home_rounded),
            ),
            BottomNavigationBarItem(
              title: Text('Calendar'),
              icon: Icon(Icons.today_rounded),
            ),
            BottomNavigationBarItem(
              title: Text('Noten'),
              icon: Icon(Icons.timeline_rounded),
            ),
            BottomNavigationBarItem(
              title: Text('Fächer'),
              icon: Icon(Icons.table_rows_rounded),
            ),
            BottomNavigationBarItem(
              title: Text('Einstellungen'),
              icon: Icon(Icons.settings_rounded),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => locator<HomeViewModel>(),
    );
  }

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
}
