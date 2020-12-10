import 'package:Classmate/app/locator.dart';

import 'package:Classmate/models/fach.dart';
import 'package:Classmate/services/services.dart';
import 'package:Classmate/ui/views/views.dart';
import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';

@singleton
class FaecherViewModel extends StreamViewModel<List<Fach>> {
  final FaecherService _faecherService = locator<FaecherService>();
  final NavigationService _navigationService = locator<NavigationService>();

  bool _hasData = false;
  int _selectedIndex = 0;

  String _initialTitle;
  bool _hasClosedSheet = false;

  @override
  Stream<List<Fach>> get stream => faecherStream;

  @override
  void onData(List<Fach> data) {
    _hasData = true;
    super.onData(data);
  }

  bool get hasData => _hasData;
  int get selectedIndex => _selectedIndex;
  String get initialTitle => _initialTitle;
  List<Fach> get faecher => data;

  Stream<List<Fach>> get faecherStream => _faecherService.streamFach();

  void initialize(
    Fach fach,
  ) {
    _initialTitle = fach.name;
    _hasClosedSheet = false;
  }

  bool controller(DraggableScrollableNotification sheet) {
    if (sheet.extent == 0.85 && _hasClosedSheet == false) {
      _hasClosedSheet = true;

      exit(true);

      return true;
    } else {
      return false;
    }
  }

  Future<void> navigateToDetailPage(
    Fach fach,
    int index,
    BuildContext context,
    GlobalKey _key,
  ) async {
    {
      Navigator.of(context).push(
        PageRouteBuilder(
          opaque: false,
          barrierColor: Colors.black.withOpacity(0.5),
          barrierDismissible: true,
          fullscreenDialog: true,
          transitionDuration: Duration(milliseconds: 500),
          reverseTransitionDuration: Duration(milliseconds: 300),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return FaecherDetailView(
              fach: fach,
              index: index,

              // neu: false,
              // colorTitle: colorTitle,
              //color: color,
              // type: type,
              heroContainer: 'Container' + index.toString() + fach.docRef,
              heroTitle: 'Title' + index.toString() + fach.docRef,
              heroPage: 'Page' + index.toString() + fach.docRef,
              heroPop: 'Pop' + index.toString() + fach.docRef,
              heroDetails: 'Details' + index.toString() + fach.docRef,
              // heroButtonRight: 'ButtonRight' + index.toString() + type.docRef,
            );
          },
        ),
      );
    }
  }

  void selectedIndexChange(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void exit(bool speichern) {
    //edited(false);

    _navigationService.back();
  }
}
