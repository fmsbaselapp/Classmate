import 'dart:math';
import 'package:Classmate/services/services.dart';
import 'package:Classmate/ui/shared/export.dart';
import 'package:Classmate/ui/views/viewmodels.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ErstellenAppBar extends SliverPersistentHeaderDelegate {
  const ErstellenAppBar(
      {@required this.color,
      @required this.colorTitle,
      this.heroContainer,
      this.heroTitle,
      this.heroPop,
      this.heroDetails,
      this.heroButtonRight,
      this.type,
      this.neu,
      Key key});

  final Color color;
  final TextStyle colorTitle;
  final String heroContainer;
  final String heroTitle;
  final String heroPop;
  final String heroDetails;
  final String heroButtonRight;
  final bool neu;
  final dynamic type;

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
          neu
              ? _AppBarContainer(
                  visibleMainHeight: visibleMainHeight, color: color)
              : Hero(
                  tag: heroContainer,
                  child: _AppBarContainer(
                      visibleMainHeight: visibleMainHeight, color: color),
                ),
          //PopButton
          neu
              ? Positioned(left: 15, child: ErstellenPopButton())
              : Positioned(
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
                                curve: Interval(0.0, 1.0,
                                    curve: Curves.easeInCirc),
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
          ErstellenAppBarTitle(
            heroTitle: heroTitle,
            type: type,
            neu: neu,
            colorTitle: colorTitle,
          ),

          //Hero Details der Aufgabe (fadetOut)
          neu
              ? Wrap()
              : Positioned(
                  top: 50,
                  left: 60,
                  child: Hero(
                    tag: heroDetails,
                    flightShuttleBuilder: (flightContext, animation,
                        flightDirection, fromHeroContext, toHeroContext) {
                      return FadeTransition(
                        opacity: animation.drive(
                          Tween<double>(begin: 0.0, end: 1.0).chain(
                            Tween<double>(begin: 1.0, end: 0.0).chain(
                              CurveTween(
                                curve: Interval(
                                  0.0,
                                  0.2,
                                ),
                              ),
                            ),
                          ),
                        ),
                        child: fromHeroContext.widget,
                      );
                    },
                    child: Opacity(
                      opacity: 0.0,
                      child: Row(
                        children: [
                          IconFach(
                            farbe: type.fachFarbe,
                            icon: type.fachIcon,
                            small: true,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            type.fachName +
                                ' | ' +
                                type.datum.weekday.toString() +
                                ',' +
                                type.datum.day.toString() +
                                type.datum.month.toString(),
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

          //CloseButton
          neu
              ? Wrap()
              : Positioned(
                  right: 15,
                  child: Hero(
                    tag: heroButtonRight,
                    flightShuttleBuilder: (flightContext, animation,
                        flightDirection, fromHeroContext, toHeroContext) {
                      return FadeTransition(
                        opacity: animation.drive(
                          Tween<double>(begin: 0.0, end: 1.0).chain(
                            Tween<double>(begin: 1.0, end: 0.0).chain(
                              CurveTween(
                                curve: Interval(
                                  0.0,
                                  0.2,
                                ),
                              ),
                            ),
                          ),
                        ),
                        child: fromHeroContext.widget,
                      );
                    },
                    child: Opacity(opacity: 0.0, child: AufgabeButton()),
                  ),
                ),

          //SafeButton
          Positioned(
            right: 15,
            child: Container(
              height: 70,
              alignment: Alignment.centerRight,
              child: ErstellenSafeButton(),
            ),
          ),
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

class _AppBarContainer extends StatelessWidget {
  const _AppBarContainer({
    Key key,
    @required this.visibleMainHeight,
    @required this.color,
  }) : super(key: key);

  final double visibleMainHeight;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: visibleMainHeight,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
    );
  }
}

class ErstellenAppBarTitle extends ViewModelWidget<ErstellenViewModel> {
  const ErstellenAppBarTitle({
    Key key,
    @required this.heroTitle,
    @required this.type,
    @required this.colorTitle,
    @required this.neu,
  }) : super(key: key);

  final bool neu;
  final String heroTitle;
  final dynamic type;
  final TextStyle colorTitle;

  @override
  Widget build(BuildContext context, ErstellenViewModel model) {
    return Positioned.fill(
      left: 60,
      right: model.showSafeButton | model.isPop ? 100 : 20,
      top: 21,
      child: neu
          ? _Title(neu: neu, type: type, colorTitle: colorTitle)
          : Hero(
              tag: heroTitle,
              child: _Title(neu: neu, type: type, colorTitle: colorTitle),
            ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    Key key,
    @required this.neu,
    @required this.type,
    @required this.colorTitle,
  }) : super(key: key);

  final bool neu;
  final type;
  final TextStyle colorTitle;

  @override
  Widget build(BuildContext context) {
    return Text(
      neu ? 'Aufgabe' : type.titel,
      style: colorTitle,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.left,
    );
  }
}

class ErstellenSafeButton extends ViewModelWidget<ErstellenViewModel> {
  const ErstellenSafeButton({Key key}) : super(key: key);

  @override
  Widget build(
    BuildContext context,
    ErstellenViewModel model,
  ) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: model.isPop ? 10 : 300),
      opacity: model.showSafeButton ? 1.0 : 0.0,
      child: TextButtonCustom(
        onPressed: model.save,
        text: 'Speichern',
      ),
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
