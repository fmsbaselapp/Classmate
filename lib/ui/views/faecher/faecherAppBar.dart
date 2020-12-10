import 'dart:math';
import 'package:Classmate/models/models.dart';
import 'package:Classmate/services/services.dart';
import 'package:Classmate/ui/shared/export.dart';
import 'package:Classmate/ui/views/viewmodels.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class FaecherAppBar extends SliverPersistentHeaderDelegate {
  const FaecherAppBar(
      {@required this.heroContainer,
      @required this.heroTitle,
      @required this.heroPop,
      @required this.heroDetails,
      // @required  this.heroButtonRight,
      @required this.fach,
      // @required  this.neu,
      Key key});

  final String heroContainer;
  final String heroTitle;
  final String heroPop;
  final String heroDetails;
  // final String heroButtonRight;
  // final bool neu;
  final Fach fach;

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
            child: _AppBarContainer(
              visibleMainHeight: visibleMainHeight,
              color: Color(fach.farbe).withOpacity(0.3),
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
          FaecherAppBarTitle(
            heroTitle: heroTitle,
            title: fach.name,
          ),

          //Hero Details der Aufgabe (fadetOut)

          /*  //SafeButton
          Positioned(
            right: 15,
            child: Container(
              height: 70,
              alignment: Alignment.centerRight,
              child: ErstellenSafeButton(
                title: title,
                neu: neu,
                type: type,
              ),
            ),
          ), */
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

class FaecherAppBarTitle extends ViewModelWidget<FaecherViewModel> {
  const FaecherAppBarTitle({
    Key key,
    @required this.title,
    @required this.heroTitle,
  }) : super(key: key);

  final String title;

  final String heroTitle;

  @override
  Widget build(BuildContext context, FaecherViewModel model) {
    return Positioned.fill(
      left: 60,
      right: 20, //model.showSafeButton | model.isPop ? 125 : 20,
      top: 21,
      child: Hero(
        tag: heroTitle,
        child: _Title(
          modelText: model.initialTitle,
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    Key key,
    this.title,
    @required this.modelText,
  }) : super(key: key);

  final String title;

  final String modelText;

  @override
  Widget build(BuildContext context) {
    return Text(
      modelText,
      style: Theme.of(context).textTheme.headline2,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.left,
    );
  }
}

class ErstellenSafeButton extends ViewModelWidget<ErstellenViewModel> {
  const ErstellenSafeButton(
      {@required this.title, @required this.neu, @required this.type, Key key})
      : super(key: key);

  final String title;
  final bool neu;

  final dynamic type;

  @override
  Widget build(
    BuildContext context,
    ErstellenViewModel model,
  ) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: model.isPop ? 10 : 300),
      opacity: model.showSafeButton ? 1.0 : 0.0,
      child: TextButtonCustom(
        onPressed: () {
          model.save(
            title,
            true,
          );
        },
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
              model.exit(false);
            },
          );
        },
        viewModelBuilder: () => locator<ErstellenViewModel>());
  }
}
