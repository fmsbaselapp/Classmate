import 'package:stacked/stacked.dart';
import 'package:injectable/injectable.dart';

@singleton
class NotenViewModel extends BaseViewModel {
  String _title = 'Hello models';
  String get title => _title;

  String _zeit = 'Hello models';
  String get zeit => _zeit;

  String _raum = 'Hello models';
  String get raum => _raum;

  int _length = 12;
  int get length => _length;
}
