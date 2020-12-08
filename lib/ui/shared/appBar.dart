import 'dart:math';

import 'package:Classmate/ui/shared/export.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({@required this.title, Key key, @required this.onPressed});

  final String title;
  final Function onPressed;

  @override
  Widget build(
    BuildContext context,
  ) {
    return SliverAppBar(
      // title: Text("SliverAppBar Title"),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      expandedHeight: 60.0,

      //pinned: true,
      //stretch: true,

      title: Padding(
        padding: EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headline1,
            ),
            RoundButton(
              iconSize: 20,
              icon: Icons.settings_rounded,
              onPressed: onPressed,
            ),
          ],
        ),
      ),
    );
  }
}
