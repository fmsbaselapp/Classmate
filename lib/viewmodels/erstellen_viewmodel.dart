import 'package:Classmate/app/locator.dart';
import 'package:Classmate/models/models.dart';
import 'package:Classmate/services/services.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

@singleton
class ErstellenViewModel extends StreamViewModel<List<Fach>> {
  final FaecherService _faecherService = locator<FaecherService>();
  final AufgabenService _aufgabenService = locator<AufgabenService>();
  final InfosService _infosService = locator<InfosService>();
  final TestsService _testsService = locator<TestsService>();
  final NavigationService _navigationService = locator<NavigationService>();

  bool _hasData = false;
  bool _isFachSelected = false;
  static String _titleAppBar;
  static Fach _fachSelected;
  static String _title;
  static DateTime _dateTime;

  bool get hasData => _hasData;
  List<Fach> get faecher => data;
  Fach get selectedFach => _fachSelected;
  bool get isFachSelected => _isFachSelected;
  String get title => _title;

  @override
  Stream<List<Fach>> get stream => faecherStream;
  Stream<List<Fach>> get faecherStream => _faecherService.streamFach();

//On List Faecher Stream data
  @override
  void onData(List<Fach> data) {
    _hasData = true;
    super.onData(data);
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
    _navigationService.popRepeated(1);
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
