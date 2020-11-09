import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

@singleton
class ErstellenViewModel extends BaseViewModel {
  String getTitle(title) {
    if (title == 'Info' || title == 'Aufgabe') {
      return title = 'Neue ' + title;
    }

    if (title == 'Test') {
      return title = 'Neuer ' + title;
    }
    //Todo? else Error
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
}
