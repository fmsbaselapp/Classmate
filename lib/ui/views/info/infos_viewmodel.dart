import 'package:Classmate/app/locator.dart';

import 'package:Classmate/models/info.dart';
import 'package:Classmate/services/services.dart';
import 'package:stacked/stacked.dart';
import 'package:injectable/injectable.dart';

@singleton
class InfosViewModel extends StreamViewModel<List<Info>> {
  final InfosService _infosService = locator<InfosService>();
  bool _hasData = false;

  bool get hasData => _hasData;
  List<Info> get infos => data;

  @override
  Stream<List<Info>> get stream => infosStream;
  Stream<List<Info>> get infosStream => _infosService.streamInfos();

  @override
  void onData(List<Info> data) {
    _hasData = true;
    super.onData(data);
  }

  @override
  void onError(error) {
    print(error);
  }
}
