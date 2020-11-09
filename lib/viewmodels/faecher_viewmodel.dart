import 'package:Classmate/app/locator.dart';

import 'package:Classmate/models/fach.dart';
import 'package:Classmate/services/services.dart';
import 'package:Classmate/ui/views/views.dart';
import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';
import 'package:injectable/injectable.dart';

@singleton
class FaecherViewModel extends StreamViewModel<List<Fach>> {
  final FaecherService _faecherService = locator<FaecherService>();

  bool _hasData = false;

  bool get hasData => _hasData;
  List<Fach> get faecher => data;

  @override
  Stream<List<Fach>> get stream => faecherStream;
  Stream<List<Fach>> get faecherStream => _faecherService.streamFach();

  @override
  void onData(List<Fach> data) {
    _hasData = true;
    super.onData(data);
  }

  Future<void> navigateToDetailPage(
      Fach fach, int index, BuildContext context) async {
    showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: true,
        backgroundColor: Theme.of(context).accentColor,
        context: context,
        builder: (context) => FaecherDetailView(
              fach: fach,
              index: index,
            ));
  }
}
