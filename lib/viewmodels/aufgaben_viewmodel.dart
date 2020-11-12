import 'package:Classmate/app/locator.dart';
import 'package:Classmate/models/aufgabe.dart';
import 'package:Classmate/services/services.dart';
import 'package:Classmate/ui/views/erstellen_view.dart';

import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';
import 'package:injectable/injectable.dart';

@singleton
class AufgabenViewModel extends StreamViewModel<List<Aufgabe>> {
  final AufgabenService _aufgabenService = locator<AufgabenService>();

  bool _hasData = false;
  double _scale = 1;

  bool get hasData => _hasData;
  List<Aufgabe> get aufgaben => data;
  double get scale => _scale;

  @override
  Stream<List<Aufgabe>> get stream => aufgabenStream;
  Stream<List<Aufgabe>> get aufgabenStream => _aufgabenService.streamAufgabe();

  @override
  void onData(List<Aufgabe> data) {
    _hasData = true;
    super.onData(data);
  }

  tapDown(TapDownDetails tapDownDetails) {
    //tapDownDetails.globalPosition.distance;
    _scale = 0.8;
    notifyListeners();
  }

  goToDetailPage(BuildContext context, GlobalKey _key) {
    final RenderBox renderBoxAufgabe = _key.currentContext.findRenderObject();
    final positionAufgabe = renderBoxAufgabe.localToGlobal(Offset.zero);
    final viewportHeigh = MediaQuery.of(context).size.height;

    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return;
        },
        transitionDuration: Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          print(positionAufgabe.dy / MediaQuery.of(context).size.height);

          Animation<double> width =
              Tween<double>(begin: 0.0, end: 1.0).animate(animation);
          Animation<double> height =
              Tween<double>(begin: 0.0, end: 1.0).animate(animation);

          print('BREITE:  ' + width.value.toString());
          print('HÖHRE:  ' + height.value.toString());
          return Align(
            child: ZoomTransition(
              sizeFactor: animation,
              width: width,
              height: height,
              child: ErstellenView(
                title: 'Aufgabe',
              ),
            ),
          );
        },
      ),
    );
  }
}

class ZoomTransition extends AnimatedWidget {
  ZoomTransition({
    Key key,
    @required Animation<double> sizeFactor,
    @required Animation<double> height,
    @required Animation<double> width,
    this.child,
  })  : assert(sizeFactor != null),
        super(key: key, listenable: sizeFactor);

  Animation<double> get sizeFactor => listenable as Animation<double>;
  Animation<double> get width => listenable as Animation<double>;
  Animation<double> get height => listenable as Animation<double>;

  final Widget child;

  get math => null;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20 - width.value * 5),
      child: Align(
        heightFactor: height.value,
        widthFactor: width.value + 0.9,
        child: child,
      ),
    );
  }
}
