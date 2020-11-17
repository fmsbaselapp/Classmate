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
  bool _hasClosedSheet = false;
  bool _hasData = false;
  final InfosService _infosService = locator<InfosService>();
  bool _isFachSelected = false;
  final NavigationService _navigationService = locator<NavigationService>();
  final TestsService _testsService = locator<TestsService>();

  @override
  Stream<List<Fach>> get stream => faecherStream;

//On List Faecher Stream data
  @override
  void onData(List<Fach> data) {
    _hasData = true;
    super.onData(data);
  }

  bool get hasData => _hasData;

  List<Fach> get faecher => data;

  Fach get selectedFach => _fachSelected;

  bool get isFachSelected => _isFachSelected;

  String get title => _title;

  Stream<List<Fach>> get faecherStream => _faecherService.streamFach();

  ScrollController get scrollController => _scrollController;

  bool controller(DraggableScrollableNotification sheet) {
    if (sheet.extent == 0.85 && _hasClosedSheet == false) {
      _hasClosedSheet = true;
      exit();

      return true;
    } else {
      return false;
    }
  }

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
    _navigationService.back();
  }

  void exit1(context) {
    _navigationService.popUntil((route) => route.isActive);
    //_navigationService.navigateToView(UebersichtView());
  }

//Titel Controller
  void updateTitle(String value) {
    _title = value;
    notifyListeners();
  }

//Für Erstellen liste
  void fachSelect(Fach fach) {
    _fachSelected = fach;
    _isFachSelected = true;
    notifyListeners();
  }

  void dateSelect(DateTime date) {
    _dateTime = date;
  }

//Weist die Farbe der AppBar zu
  Color getColor(titleAppBar) {
    //TODO Colors zu theme
    if (titleAppBar == 'Infos') {
      _titleAppBar = 'Info';
      return Color.fromRGBO(252, 192, 45, 1);
    }

    if (titleAppBar == 'Aufgaben') {
      _titleAppBar = 'Aufgabe';
      return Colors.blue;
    }

    if (titleAppBar == 'Tests') {
      _titleAppBar = 'Test';
      return Colors.red;
    }
    //TODO else Error
  }

  //ERSTELLEN
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
        datum: _dateTime,
        fachName: _fachSelected.name,
        fachFarbe: _fachSelected.farbe,
        fachIcon: _fachSelected.icon));
  }
}
