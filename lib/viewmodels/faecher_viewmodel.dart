import 'package:Classmate/app/locator.dart';
import 'package:Classmate/models/fach.dart';
import 'package:Classmate/services/services.dart';
import 'package:stacked/stacked.dart';
import 'package:injectable/injectable.dart';

@singleton
class FaecherViewModel extends StreamViewModel<Fach> {
  final FaecherService _faecherService = locator<FaecherService>();

  String get name => data.name;
  Fach get fach => data;

  @override
  Stream<Fach> get stream => faecherStream;
  Stream<Fach> get faecherStream => _faecherService.streamFach();
}
