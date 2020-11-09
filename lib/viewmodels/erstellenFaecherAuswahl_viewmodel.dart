import 'package:Classmate/app/locator.dart';
import 'package:Classmate/models/models.dart';
import 'package:Classmate/services/services.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

@singleton
class ErstellenFaecherAuswahlViewModel extends StreamViewModel<List<Fach>> {
  final FaecherService _faecherService = locator<FaecherService>();
  bool _hasData = false;
  Fach _fachSelected;
  bool _isFachSelected = false;
  bool _expanded = false;

  bool get hasData => _hasData;
  List<Fach> get faecher => data;
  Fach get selectedFach => _fachSelected;
  bool get isFachSelected => _isFachSelected;
  bool get isExpanded => _expanded;

  @override
  Stream<List<Fach>> get stream => faecherStream;
  Stream<List<Fach>> get faecherStream => _faecherService.streamFach();

  @override
  void onData(List<Fach> data) {
    _hasData = true;
    super.onData(data);
  }

  Color getColor(title) {
    //TODO Colors zu theme
    if (title == 'Info') {
      return Colors.yellow;
    }

    if (title == 'Aufgabe') {
      return Colors.blue;
    }

    if (title == 'Test') {
      return Colors.red;
    }
    //Todo? else Error
  }

//Für Erstellen liste
  void fachSelect(Fach fach) {
    _fachSelected = fach;
    _isFachSelected = true;
    expanded();
    notifyListeners();
  }

  void expanded() {
    if (_expanded) {
      _expanded = false;
    } else {
      _expanded = true;
    }
    notifyListeners();
  }
}
