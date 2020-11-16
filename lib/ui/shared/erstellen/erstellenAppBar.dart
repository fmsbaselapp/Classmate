import 'dart:math';

import 'package:Classmate/ui/shared/export.dart';
import 'package:Classmate/ui/views/viewmodels.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ErstellenAppBar extends SliverPersistentHeaderDelegate {
  const ErstellenAppBar(
      {@required this.title,
      @required this.color,
      this.heroContainer,
      this.heroTitle,
      Key key});

  final String title;
  final Color color;
  final String heroContainer;
  final String heroTitle;

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

    return Stack(
      children: [
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
        Positioned(top: 30, left: 15, bottom: 10, child: ErstellenPopButton()),
        Positioned(
          top: 30,
          left: 60,
          bottom: 10,
          child: Hero(
            tag: heroTitle,
            child: Text(
              title,
              style:
                  Theme.of(context).textTheme.headline1.copyWith(fontSize: 30),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Positioned(
            top: 30, right: 15, bottom: 10, child: ErstellenSafeButton()),
      ],
    );
  }

  @override
  double get maxExtent => 75.0;

  @override
  double get minExtent => 75.0;

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

class ErstellenPopButton extends ViewModelWidget<ErstellenViewModel> {
  const ErstellenPopButton({Key key}) : super(key: key);

  @override
  Widget build(
    BuildContext context,
    ErstellenViewModel model,
  ) {
    return RoundButton(
        icon: Icons.clear_rounded,
        onPressed: () {
          model.exit();
        });
  }
}
