import 'package:Classmate/app/locator.dart';

import 'package:Classmate/models/models.dart';
import 'package:Classmate/services/services.dart';
import 'package:stacked/stacked.dart';
import 'package:injectable/injectable.dart';

@singleton
class TestsViewModel extends StreamViewModel<List<Test>> {
  final TestsService _testsService = locator<TestsService>();
  bool _hasData = false;

  bool get hasData => _hasData;
  List<Test> get tests => data;

  @override
  Stream<List<Test>> get stream => testStream;
  Stream<List<Test>> get testStream => _testsService.streamTests();

  @override
  void onData(List<Test> data) {
    _hasData = true;
    super.onData(data);
  }
}
