import 'package:Classmate/models/models.dart';
import 'package:Classmate/ui/views/erstellen/erstellen_view.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

@singleton
class ContentPanelViewModel extends BaseViewModel {
  goToDetailPage(BuildContext context, int index, GlobalKey _key, dynamic type,
      Color color, TextStyle colorTitle) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black.withOpacity(0.5),
        barrierDismissible: true,
        fullscreenDialog: true,
        transitionDuration: Duration(milliseconds: 500),
        reverseTransitionDuration: Duration(milliseconds: 300),
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return ErstellenView(
            colorTitle: colorTitle,
            color: color,
            type: type,
            heroContainer: 'Container' + index.toString() + type.titel,
            heroTitle: 'Title' + index.toString() + type.titel,
            heroPage: 'Page' + index.toString() + type.titel,
            heroPop: 'Pop' + index.toString() + type.titel,
            heroDetails: 'Details' + index.toString() + type.titel,
            heroButtonRight: 'ButtonRight' + index.toString() + type.titel,
          );
        },
      ),
    );
  }

  type(bool isAufgabe, bool isTest, bool isInfo, dynamic content) {
    if (isAufgabe) {
      Aufgabe type = content;
      return type;
    }
    if (isTest) {
      Test type = content;
      return type;
    }
    if (isInfo) {
      Info type = content;
      return type;
    }
  }
}
