import 'package:Classmate/app/locator.dart';
import 'package:Classmate/models/models.dart';
import 'package:Classmate/services/services.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

@singleton
class ErstellenViewModel extends StreamViewModel<List<Fach>> {
  static DateTime _dateTime;
  static Fach _fachSelected;
  static ScrollController _scrollController;
  static String _title;
  static String _titleAppBar;

  final AufgabenService _aufgabenService = locator<AufgabenService>();
  final FaecherService _faecherService = locator<FaecherService>();
  final InfosService _infosService = locator<InfosService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final TestsService _testsService = locator<TestsService>();

  bool _hasClosedSheet = false;
  bool _hasData = false;
  bool _isFachSelected = false;
  bool _isAuswahlExpanded = false;
  bool _showSafeButton = false;
  bool _isPop = false;
  bool _isFuerAlle = true;
  // bool _dissmissSheet = true;

  @override
  Stream<List<Fach>> get stream => faecherStream;

  bool get hasData => _hasData;

  List<Fach> get faecher => data;
  Fach get selectedFach => _fachSelected;
  // bool get dismissSheet => _dissmissSheet;
  bool get isExpanded => _isAuswahlExpanded;
  bool get isFachSelected => _isFachSelected;
  bool get isPop => _isPop;
  bool get isFuerAlle => _isFuerAlle;

  bool get showSafeButton => _showSafeButton;

  Stream<List<Fach>> get faecherStream => _faecherService.streamFach();
  ScrollController get scrollController => _scrollController;

  //On List Faecher Stream data
  @override
  void onData(List<Fach> data) {
    _hasData = true;
    super.onData(data);
  }

  void initialize(bool neu) {
    _showSafeButton = false;
    _hasClosedSheet = false;
    _isFachSelected = false;
    _isAuswahlExpanded = false;

    _isPop = false;
    //initializeSheet(neu);
  }

  /*  initializeSheet(bool neu) {
    // _dissmissSheet = false;
    notifyListeners();
  } */

  fuerAlleChange() {
    _isFuerAlle = !_isFuerAlle;

    notifyListeners();
  }

  bool controller(DraggableScrollableNotification sheet) {
    if (sheet.extent == 0.85 && _hasClosedSheet == false) {
      _hasClosedSheet = true;
      exit();

      return true;
    } else {
      return false;
    }
  }

  /* void dismissSheetChange(bool changeTo) {
    if (changeTo == false) {
      _dissmissSheet = false;
      notifyListeners();
    } else if (changeTo == false) {
      _dissmissSheet = false;
      notifyListeners();
    }
  } */

  void faecherAuswahlController() {
    _isAuswahlExpanded = !_isAuswahlExpanded;
    notifyListeners();
  }

  void faecherAuswahlShow() {
    Future.delayed(Duration(milliseconds: 500)).then(
      (value) {
        notifyListeners();
      },
    );
  }

  void showSafeButtonChange(bool show) {
    if (show) {
      _showSafeButton = true;
      notifyListeners();
    } else
      _showSafeButton = false;
    notifyListeners();
  }

//Titel Controller
  void updateTitle(String value) {
    _title = value;

    notifyListeners();
    /*  if (value == "h") {
      dismissSheetChange(false);
    } else {
      dismissSheetChange(true);
    } */

    showSafeButtonChange(true);
  }

//Für Erstellen liste
  void fachSelect(Fach fach) {
    _fachSelected = fach;
    _isFachSelected = true;
    _isAuswahlExpanded = false;
    notifyListeners();
  }

  void dateSelect(DateTime date) {
    _dateTime = date;
  }

//ERSTELLEN

//Daten in der Datenbank sichern
  void save() {
    if (_titleAppBar == 'Info') {
      saveInfo();
    }
    if (_titleAppBar == 'Aufgabe') {
      saveAufgabe();
    }
    if (_titleAppBar == 'Test') {
      saveTest();
    }
    //TODO else Error
  }

  void exit() {
    showSafeButtonChange(false);
    //für SafeButton
    _isPop = true;

    notifyListeners();
    _navigationService.back();
  }

/*
  void exit1(context) {
    _navigationService.popUntil((route) => route.isActive);
    //_navigationService.navigateToView(UebersichtView());
  }
*/

  void saveAufgabe() {
    print(
        _title + ' - ' + _fachSelected.name + ' - ' + _dateTime.day.toString());
    _aufgabenService.setAufgabe(Aufgabe(
        titel: _title,
        datum: _dateTime,
        fachName: _fachSelected.name,
        fachFarbe: _fachSelected.farbe,
        fachIcon: _fachSelected.icon));
  }

  void saveTest() {
    print(
        _title + ' - ' + _fachSelected.name + ' - ' + _dateTime.day.toString());
    _testsService.setTest(Test(
        titel: _title,
        datum: _dateTime,
        fachName: _fachSelected.name,
        fachFarbe: _fachSelected.farbe,
        fachIcon: _fachSelected.icon));
  }

  void saveInfo() {
    print(
        _title + ' - ' + _fachSelected.name + ' - ' + _dateTime.day.toString());
    _infosService.setInfo(Info(
        titel: _title,
        datum: DateTime.now(), //_dateTime,
        fachName: _fachSelected.name,
        fachFarbe: _fachSelected.farbe,
        fachIcon: _fachSelected.icon));
  }

  void delete(type) {
    switch (type.typeName) {
      case 'Info':
        return print(type.docRef);

      case 'Aufgabe':
        _aufgabenService.deleteAufgabe(type);
        return exit();

      case 'Test':
        return print(type.docRef);
        break;
      default:
    }

    print('deleted');
  }
}
