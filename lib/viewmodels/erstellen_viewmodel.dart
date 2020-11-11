import 'package:Classmate/app/locator.dart';
import 'package:Classmate/models/models.dart';
import 'package:Classmate/services/services.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

@singleton
class ErstellenViewModel extends StreamViewModel<List<Fach>> {
  final FaecherService _faecherService = locator<FaecherService>();

  bool _hasData = false;
  bool _isFachSelected = false;
  bool _expanded = false;
  static Fach _fachSelected;
  static String _title;
  static DateTime _dateTime;

  bool get hasData => _hasData;
  List<Fach> get faecher => data;
  Fach get selectedFach => _fachSelected;
  bool get isFachSelected => _isFachSelected;
  bool get isExpanded => _expanded;
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
  void safe() {
    print(
        _title + ' - ' + _fachSelected.name + ' - ' + _dateTime.day.toString());
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
    expanded();
    notifyListeners();
  }

  void dateSelect(DateTime date) {
    _dateTime = date;
  }

//Weist die Farbe der AppBar zu
  Color getColor(title) {
    //TODO Colors zu theme
    if (title == 'Info') {
      return Color.fromRGBO(252, 192, 45, 1);
    }

    if (title == 'Aufgabe') {
      return Colors.blue;
    }

    if (title == 'Test') {
      return Colors.red;
    }
    //TODO else Error
  }

//wechselt den expanded status von offen nach geschlossen und umgekehrt
  void expanded() {
    if (_expanded) {
      _expanded = false;
    } else {
      _expanded = true;
    }
    notifyListeners();
  }
}
