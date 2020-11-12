import 'dart:math';

import 'package:Classmate/ui/shared/export.dart';
import 'package:Classmate/viewmodels/viewmodels.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ErstellenAppBar extends SliverPersistentHeaderDelegate {
  const ErstellenAppBar({@required this.title, @required this.color, Key key});

  final String title;
  final Color color;

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
    return Container(
      color: color,
      height: visibleMainHeight,
      width: MediaQuery.of(context).size.width,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 30, bottom: 10, left: 15, right: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Align(
                    alignment: Alignment.topLeft, child: ErstellenPopButton()),
              ),
              Expanded(
                flex: 4,
                child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.topRight,
                  child: ErstellenSafeButton(),
                ),
              )
            ],
          ),
        ),
      ),
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
