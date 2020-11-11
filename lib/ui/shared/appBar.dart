import 'dart:math';

import 'package:Classmate/ui/shared/export.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends SliverPersistentHeaderDelegate {
  const CustomAppBar({@required this.title, Key key});

  final String title;

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
      // color: Colors.blue,
      height: visibleMainHeight,
      width: MediaQuery.of(context).size.width,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(title, style: Theme.of(context).textTheme.headline1
                  //.copyWith(fontSize: 30),
                  ),
              RoundButton(
                iconSize: 20,
                icon: Icons.settings_rounded,
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 50.0;

  @override
  double get minExtent => 50.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
