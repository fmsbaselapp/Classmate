import 'dart:math';

import 'package:Classmate/models/models.dart';
import 'package:Classmate/services/services.dart';
import 'package:Classmate/ui/shared/export.dart';
import 'package:Classmate/ui/views/viewmodels.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ErstellenAppBar extends SliverPersistentHeaderDelegate {
  const ErstellenAppBar(
      {@required this.color,
      this.heroContainer,
      this.heroTitle,
      this.heroPop,
      this.heroDetails,
      this.aufgabe,
      Key key});

  final Color color;
  final String heroContainer;
  final String heroTitle;
  final String heroPop;
  final String heroDetails;

  final Aufgabe aufgabe;

  double scrollAnimationValue(double shrinkOffset) {
    double maxScrollAllowed = maxExtent - minExtent;
    return ((maxScrollAllowed - shrinkOffset) / maxScrollAllowed)
        .clamp(0, 1)
        .toDouble();
  }

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final double visibleMainHeight = max(maxExtent - shrinkOffset, minExtent);

    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          //Container
          Hero(
            tag: heroContainer,
            child: Container(
              height: visibleMainHeight,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Color.fromRGBO(24, 118, 210, 1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
            ),
          ),
          //PopButton
          Positioned(
            left: 15,
            child: Container(
              height: 70,
              alignment: Alignment.centerLeft,
              child: Hero(
                tag: heroPop,
                flightShuttleBuilder: (flightContext, animation,
                    flightDirection, fromHeroContext, toHeroContext) {
                  final Hero toHero = toHeroContext.widget;
                  return FadeTransition(
                    opacity: animation.drive(
                      Tween<double>(begin: 0.0, end: 1.0).chain(
                        CurveTween(
                          curve: Interval(0.0, 1.0, curve: Curves.easeInCirc),
                        ),
                      ),
                    ),
                    child: toHero.child,
                  );
                },
                child: Opacity(opacity: 1.0, child: ErstellenPopButton()),
              ),
            ),
          ),
          //title
          Positioned.fill(
            left: 60,
            right: 100,
            top: 21,
            child: Hero(
              tag: heroTitle,
              child: Text(
                aufgabe.titel,
                style: Theme.of(context).textTheme.headline2,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
              ),
            ),
          ),

          //Hero Details (fadetOut)
          Positioned(
            top: 50,
            left: 60,
            child: Hero(
              tag: heroDetails,
              flightShuttleBuilder: (flightContext, animation, flightDirection,
                  fromHeroContext, toHeroContext) {
                final Hero toHero = toHeroContext.widget;
                return FadeTransition(
                  opacity: animation.drive(
                    Tween<double>(begin: 1.0, end: 0.0).chain(
                      CurveTween(
                        curve: Interval(
                          0.0,
                          1.0,
                        ),
                      ),
                    ),
                  ),
                  child: toHero,
                );
              },
              child: Opacity(
                opacity: 0.0,
                child: Row(
                  children: [
                    IconFach(
                      farbe: aufgabe.fachFarbe,
                      icon: aufgabe.fachIcon,
                      small: true,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      aufgabe.fachName +
                          ' | ' +
                          aufgabe.datum.weekday.toString() +
                          ',' +
                          aufgabe.datum.day.toString() +
                          aufgabe.datum.month.toString(),
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
            ),
          ),

          //SafeButton
          Positioned(
            right: 15,
            child: Container(
              height: 70,
              alignment: Alignment.centerRight,
              child: FadeIn(
                child: ErstellenSafeButton(),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  double get maxExtent => 70.0;

  @override
  double get minExtent => 70.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class ErstellenSafeButton extends ViewModelWidget<ErstellenViewModel> {
  const ErstellenSafeButton({Key key}) : super(key: key);

  @override
  Widget build(
    BuildContext context,
    ErstellenViewModel model,
  ) {
    return TextButtonCustom(
      onPressed: model.save,
      text: 'Speichern',
    );
  }
}

class ErstellenPopButton extends StatelessWidget {
  const ErstellenPopButton({Key key}) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return ViewModelBuilder<ErstellenViewModel>.nonReactive(
        disposeViewModel: false,
        //initialiseSpecialViewModelsOnce: true,
        builder: (context, model, child) {
          return RoundButton(
            icon: Icons.clear_rounded,
            onPressed: () {
              model.exit();
            },
          );
        },
        viewModelBuilder: () => locator<ErstellenViewModel>());
  }
}
