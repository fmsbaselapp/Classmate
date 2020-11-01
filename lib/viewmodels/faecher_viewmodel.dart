import 'package:Classmate/app/locator.dart';
import 'package:Classmate/models/fach.dart';
import 'package:Classmate/services/services.dart';
import 'package:stacked/stacked.dart';
import 'package:injectable/injectable.dart';

@singleton
class FaecherViewModel extends StreamViewModel<AlleFaecher> {
  final FaecherService _faecherService = locator<FaecherService>();
  AlleFaecher faecherData = AlleFaecher(faecher: []);
  bool _hasData = false;

  bool get hasData => _hasData;
  List<Fach> get faecher => faecherData.faecher;

  @override
  Stream<AlleFaecher> get stream => faecherStream;
  Stream<AlleFaecher> get faecherStream => _faecherService.streamFach();

  @override
  void onData(AlleFaecher data) {
    _hasData = true;
    faecherData = data;
    super.onData(data);
  }
}
