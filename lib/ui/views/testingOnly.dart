import 'dart:math';

import 'package:Classmate/models/models.dart';

import 'package:flutter/material.dart';

class ViewForTesting extends StatelessWidget {
  const ViewForTesting({this.heroContainer, this.aufgabe, Key key})
      : super(key: key);

  final String heroContainer;
  final Aufgabe aufgabe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.95,
        minChildSize: 0.85,
        maxChildSize: 0.95,
        builder: (context, scrollController) {
          return ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20.0),
              topRight: const Radius.circular(20.0),
            ),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onPanDown: (_) {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: CustomScrollView(
                slivers: [
                  SliverPersistentHeader(
                      delegate: HeroAppBar(
                          color: Colors.blue,
                          title: 'Aufgaben',
                          heroContainer: heroContainer)),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Container(
                          height: 10,
                          color: Colors.red,
                          child: Material(
                            color: Colors.transparent,
                            child: Text(
                              'Test',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class HeroAppBar extends SliverPersistentHeaderDelegate {
  const HeroAppBar(
      {@required this.title,
      @required this.color,
      this.heroContainer,
      Key key});
  final String heroContainer;
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
    return Hero(
      tag: heroContainer,
      child: Container(
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
                      alignment: Alignment.topLeft,
                      child: MaterialButton(
                        onPressed: () {},
                      )),
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
                    child: MaterialButton(
                      onPressed: () {},
                    ),
                  ),
                )
              ],
            ),
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
