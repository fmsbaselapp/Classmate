import 'package:Classmate/app/locator.dart';
import 'package:Classmate/models/aufgabe.dart';
import 'package:Classmate/services/services.dart';
import 'package:Classmate/ui/views/erstellen/erstellen_view.dart';

import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';

@singleton
class AufgabenViewModel extends StreamViewModel<List<Aufgabe>> {
  final AufgabenService _aufgabenService = locator<AufgabenService>();
  final NavigationService _navigationService = locator<NavigationService>();

  bool _hasData = false;
  //Animation<double> _animation;

  bool get hasData => _hasData;
  List<Aufgabe> get aufgaben => data;
  //Animation<double> get animation => _animation;

  @override
  Stream<List<Aufgabe>> get stream => aufgabenStream;
  Stream<List<Aufgabe>> get aufgabenStream => _aufgabenService.streamAufgabe();

  get math => null;

  @override
  void onData(List<Aufgabe> data) {
    _hasData = true;
    super.onData(data);
  }

  tapDown(TapDownDetails tapDownDetails) {
    //_scale = 560 / tapDownDetails.globalPosition.distance;
    notifyListeners();
  }

  goToDetailPage(BuildContext context, int index, GlobalKey _key) {
    _navigationService.navigateWithTransition(
        ErstellenView(
          title: aufgaben[index].titel,
          aufgabe: aufgaben[index],
          heroContainer: 'Container' + index.toString() + aufgaben[index].titel,
          heroTitle: 'Title' + index.toString() + aufgaben[index].titel,
          heroPage: 'Page' + index.toString() + aufgaben[index].titel,
        ),
        duration: Duration(milliseconds: 2000),
        transition: 'fade');

/*
    Navigator.of(context).push(
      PageRouteBuilder(
        fullscreenDialog: true,
        transitionDuration: Duration(milliseconds: 5000),
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return ErstellenView(
            title: aufgaben[index].titel,
            aufgabe: aufgaben[index],
            heroContainer:
                'Container' + index.toString() + aufgaben[index].titel,
            heroTitle: 'Title' + index.toString() + aufgaben[index].titel,
            heroPage: 'Page' + index.toString() + aufgaben[index].titel,
          );
        },
        transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );*/
  }
}

class ZoomTransition extends AnimatedWidget {
  ZoomTransition({
    Key key,
    @required Animation<double> sizeFactor,
    @required Animation<double> height,
    @required Animation<double> width,
    this.viewPortHeigh,
    this.position,
    this.child,
  })  : assert(sizeFactor != null),
        super(key: key, listenable: sizeFactor);

  Animation<double> get sizeFactor => listenable as Animation<double>;
  Animation<double> get width => listenable as Animation<double>;
  Animation<double> get height => listenable as Animation<double>;

  final double viewPortHeigh;
  final Offset position;
  final Widget child;

  get math => null;

  @override
  Widget build(BuildContext context) {
    print(position.dy.toString() + '   ' + viewPortHeigh.toString());
    print(viewPortHeigh / position.dy);
    print('höhe= ' + height.value.toString());
    return ClipRRect(
      // borderRadius: BorderRadius.circular(20 - width.value * 10),
      child: Align(
        alignment: Alignment(0, 2.5),
        heightFactor: height.value,
        widthFactor: 1,
        child: child,
      ),
    );
  }
}

/*
goToDetailPage(BuildContext context, int index, GlobalKey _key) {
    final RenderBox renderBoxAufgabe = _key.currentContext.findRenderObject();
    final positionAufgabe = renderBoxAufgabe.localToGlobal(Offset.zero);
    final viewPortHeigh = MediaQuery.of(context).size.height;

    Navigator.of(context).push(
      PageRouteBuilder(
        fullscreenDialog: true,
        transitionDuration: Duration(milliseconds: 5000),
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return ErstellenView(
            title: aufgaben[index].titel,
            aufgabe: aufgaben[index],
            heroContainer:
                'Container' + index.toString() + aufgaben[index].titel,
            heroTitle: 'Title' + index.toString() + aufgaben[index].titel,
            heroPage: 'Page' + index.toString() + aufgaben[index].titel,
          );
        },
        transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
          var curve = Curves.easeInOutCubic;
          var anima = Tween<double>(begin: 0.0, end: 1.0)
              .chain(CurveTween(curve: curve));
          Animation<double> width =
              Tween<double>(begin: 0.0, end: 1.0).animate(animation);

          

          return Align(
            child: ZoomTransition(
              sizeFactor: animation.drive(anima),
              width: width,
              height: animation.drive(anima),
              child: child,
              position: positionAufgabe,
              viewPortHeigh: viewPortHeigh,
            ),
          );
        },
      ),
    );
  }
}
*/

/// 2.5 386
///

/*
  oldgoToDetailPage(BuildContext context, GlobalKey _key) {
    final RenderBox renderBoxAufgabe = _key.currentContext.findRenderObject();
    final positionAufgabe = renderBoxAufgabe.localToGlobal(Offset.zero);
    //final viewportHeigh = MediaQuery.of(context).size.height;

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
}*/