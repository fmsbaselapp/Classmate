import 'package:Classmate/app/locator.dart';
import 'package:Classmate/models/aufgabe.dart';
import 'package:Classmate/services/services.dart';
import 'package:stacked/stacked.dart';
import 'package:injectable/injectable.dart';

@singleton
class AufgabenViewModel extends StreamViewModel<List<Aufgabe>> {
  final AufgabenService _aufgabenService = locator<AufgabenService>();
  bool _hasData = false;

  bool get hasData => _hasData;
  List<Aufgabe> get aufgaben => data;

  @override
  Stream<List<Aufgabe>> get stream => aufgabenStream;
  Stream<List<Aufgabe>> get aufgabenStream => _aufgabenService.streamAufgabe();

  @override
  void onData(List<Aufgabe> data) {
    _hasData = true;
    super.onData(data);
  }
}
