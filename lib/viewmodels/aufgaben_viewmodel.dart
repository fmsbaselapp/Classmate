import 'package:Classmate/app/locator.dart';
import 'package:Classmate/models/aufgabe.dart';
import 'package:Classmate/services/services.dart';
import 'package:stacked/stacked.dart';
import 'package:injectable/injectable.dart';

@singleton
class AufgabenViewModel extends StreamViewModel<AlleAufgaben> {
  final AufgabenService _aufgabenService = locator<AufgabenService>();
  bool _hasData = false;

  bool get hasData => _hasData;
  List<Aufgabe> get aufgaben => data.aufgaben;

  @override
  Stream<AlleAufgaben> get stream => aufgabenStream;
  Stream<AlleAufgaben> get aufgabenStream => _aufgabenService.streamAufgabe();

  @override
  void onData(AlleAufgaben data) {
    _hasData = true;
    super.onData(data);
  }
}
