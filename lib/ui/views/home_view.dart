import 'package:Classmate/core/viewmodels/viewmodels.dart';
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
          backgroundColor: Colors.grey[800],
          currentIndex: model.currentIndex,
          onTap: model.setIndex,
          items: [
            BottomNavigationBarItem(
              title: Text('Übersicht'),
              icon: Icon(Icons.art_track),
            ),
            BottomNavigationBarItem(
              title: Text('Calendar'),
              icon: Icon(Icons.list),
            ),
            BottomNavigationBarItem(
              title: Text('Noten'),
              icon: Icon(Icons.list),
            ),
            BottomNavigationBarItem(
              title: Text('Fächer'),
              icon: Icon(Icons.list),
            ),
            BottomNavigationBarItem(
              title: Text('Einstellungen'),
              icon: Icon(Icons.list),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => HomeViewModel(),
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
