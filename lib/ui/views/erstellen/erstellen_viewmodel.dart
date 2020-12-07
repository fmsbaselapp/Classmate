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
  static String _notiz;

  final AufgabenService _aufgabenService = locator<AufgabenService>();
  final FaecherService _faecherService = locator<FaecherService>();
  final InfosService _infosService = locator<InfosService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final TestsService _testsService = locator<TestsService>();
  final DialogService _dialogService = locator<DialogService>();

  String _initialTitle;
  String _initialNotiz;
  Fach _initialFach;
  bool _hasClosedSheet = false;
  bool _hasData = false;
  bool _isFachSelected = false;
  bool _isAuswahlExpanded = false;
  bool _showSafeButton = false;
  bool _isPop = false;
  bool _isFuerAlle = true;
  bool _dissmissSheet = true;
  bool _edited = false;

  @override
  Stream<List<Fach>> get stream => faecherStream;

  bool get hasData => _hasData;

  List<Fach> get faecher => data;
  Fach get selectedFach => _fachSelected;
  bool get dismissSheet => _dissmissSheet;
  bool get isExpanded => _isAuswahlExpanded;
  bool get isFachSelected => _isFachSelected;
  bool get isPop => _isPop;
  bool get isFuerAlle => _isFuerAlle;
  bool get showSafeButton => _showSafeButton;
  String get initialTitle => _initialTitle;
  String get initialNotiz => _initialNotiz;

  Stream<List<Fach>> get faecherStream => _faecherService.streamFach();

  //On List Faecher Stream data
  @override
  void onData(List<Fach> data) {
    _hasData = true;
    super.onData(data);
  }

//=======INITIALIZER=====================================================================================

  void initialize(bool neu, dynamic type, String initialTitle) {
    _initialTitle = initialTitle;
    _showSafeButton = false;
    _hasClosedSheet = false;
    _isAuswahlExpanded = false;
    _isFachSelected = false;
    _isPop = false;
    _edited = false;
    _initialNotiz = !neu ? type.notiz : '';
    _dissmissSheet = true;
    fachSelectInitialize(neu, type);
    //initializeSheet(neu);
  }

  void fachSelectInitialize(bool neu, dynamic type) {
    if (neu) {
      _isFachSelected = false;
    } else {
      Fach fach = Fach(
          //TODO: Aufgabe hat nicht alle Infos des Fachs sondern nur name, farbe und info
          //muss das entsprechende Fach mithilfe der id anfragen, wenn die aufgabe geöffnet wird?
          name: type.fachName,
          farbe: type.fachFarbe,
          icon: type.fachIcon);
      _initialFach = fach;
      fachSelect(fach);
    }
  }

  /*  initializeSheet(bool neu) {
    // _dissmissSheet = false;
    notifyListeners();
  } */

//=======INPUT=====================================================================================

//Titel Controller
  void updateTitle(String value) {
    _title = value;
    notifyListeners();
    /*  if (value == "h") {
      dismissSheetChange(false);
    } else {
      dismissSheetChange(true);
    } */
    if (value != _initialTitle) {
      edited(true);
    } else {
      edited(false);
    }
  }

  //Titel Controller
  void updateNotiz(String value) {
    _notiz = value;
    notifyListeners();
    if (value != _initialNotiz) {
      edited(true);
    } else {
      edited(false);
    }
  }

//Für Erstellen liste
  void fachSelect(Fach fach) {
    _fachSelected = fach;
    _isFachSelected = true;
    _isAuswahlExpanded = false;
    notifyListeners();
    if (fach != _initialFach) {
      edited(true);
    } else {
      edited(false);
    }
  }

  void dateSelect(DateTime date) {
    _dateTime = date;
  }

  void fuerAlleChange() {
    _isFuerAlle = !_isFuerAlle;

    notifyListeners();
  }

//=======CONTROLLERS=====================================================================================

  bool controller(DraggableScrollableNotification sheet) {
    if (sheet.extent == 0.85 && _hasClosedSheet == false) {
      _hasClosedSheet = true;

      exit();

      return true;
    } else {
      return false;
    }
  }

  void dismissSheetChange(bool changeTo) {
    if (changeTo == false) {
      _dissmissSheet = false;
      notifyListeners();
    } else if (changeTo == true) {
      _dissmissSheet = true;
      notifyListeners();
    }
  }

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

  void edited(bool edited) {
    if (edited) {
      _edited = true;
      _showSafeButton = true;

      notifyListeners();
      dismissSheetChange(false);
    } else {
      _edited = false;
      _showSafeButton = false;
      notifyListeners();
      dismissSheetChange(true);
    }
  }

//=======ERSTELLEN=====================================================================================

//Daten in der Datenbank sichern
  void save(String title, dynamic type, bool neu) {
    if (neu) {
      if (title == 'Neue Info') {
        saveInfo(false, type);
      }
      if (title == 'Neue Aufgabe') {
        saveAufgabe(false, type);
      }
      if (title == 'Neuer Test') {
        saveTest(false, type);
      }
    } else {
      if (type.typeName == 'Info') {
        saveInfo(true, type);
      }
      if (type.typeName == 'Aufgabe') {
        saveAufgabe(true, type);
      }
      if (type.typeName == 'Test') {
        saveTest(true, type);
      }
    }

    //TODO else Error
    exit();
  }

  void saveAufgabe(bool update, dynamic type) {
    print(_title + ' - ' + _fachSelected.name + ' - ');

    Aufgabe aufgabe = Aufgabe(
        titel: _title,
        datum: _dateTime,
        notiz: _notiz,
        fachName: _fachSelected.name,
        fachFarbe: _fachSelected.farbe,
        fachIcon: _fachSelected.icon,
        docRef: update ? type.docRef : null);

    if (update) {
      _aufgabenService.updateAufgabe(aufgabe);
    } else {
      _aufgabenService.setAufgabe(aufgabe);
    }
  }

  void saveTest(bool update, dynamic type) {
    print(_title + ' - ' + _fachSelected.name + ' - ');

    Test test = Test(
        titel: _title,
        datum: _dateTime,
        notiz: _notiz,
        fachName: _fachSelected.name,
        fachFarbe: _fachSelected.farbe,
        fachIcon: _fachSelected.icon,
        docRef: update ? type.docRef : null);

    if (update) {
      _testsService.updateTest(test);
    } else {
      _testsService.setTest(test);
    }
  }

  void saveInfo(bool update, dynamic type) {
    print(_title +
        ' - ' +
        _fachSelected.name +
        ' - ' +
        DateTime.now().toString()); //_dateTime.day.toString()

    Info info = Info(
        titel: _title,
        notiz: _notiz,
        datum: DateTime.now(), //_dateTime,
        fachName: _fachSelected.name,
        fachFarbe: _fachSelected.farbe,
        fachIcon: _fachSelected.icon,
        docRef: update ? type.docRef : null);

    if (update) {
      _infosService.updateInfo(info);
    } else {
      _infosService.setInfo(info);
    }
  }

  void delete(type) {
    switch (type.typeName) {
      case 'Info':
        _infosService.deleteInfo(type);
        return exit();

      case 'Aufgabe':
        _aufgabenService.deleteAufgabe(type);
        return exit();

      case 'Test':
        _testsService.deleteTest(type);
        return exit();
        break;
      default:
    }

    print('deleted');
  }

  //=======Exit=====================================================================================

  void exit() async {
    //edited(false);

    if (_edited) {
      print('hellou');
      FocusManager.instance.primaryFocus.unfocus();
      Future.delayed(Duration(milliseconds: 100)).then((value) async {
        var response = await _dialogService.showDialog(
          title: 'Speichern?',
          description: '\nMöchtest du die Änderungen speichern?',
          dialogPlatform: DialogPlatform.Cupertino,
          cancelTitle: 'Abbrechen',
          buttonTitle: 'Speichern',
        );
        if (response.confirmed) {
          // save();
        } else {
          _isPop = true;
          notifyListeners();
          _navigationService.back();
        }
      });
    } else {
      //für SafeButton verschwinden und einblenden
      _isPop = true;
      notifyListeners();
      _navigationService.back();
    }
  }
}
