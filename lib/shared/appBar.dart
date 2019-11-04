import 'package:flutter/material.dart';

class ClassmateAppBar extends StatelessWidget implements PreferredSizeWidget {
  ClassmateAppBar({this.children, this.height, this.mainAxisAlignment});

  final double height; //80
  List<Widget> children;
  MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Container(
          
          width: double.infinity,
          height: height,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 10,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.spaceBetween,
              
              children: children,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class ClassmateTabBar extends StatelessWidget implements PreferredSizeWidget {
  ClassmateTabBar({this.children, this.height, this.mainAxisAlignment});

  final double height; //80
  List<Widget> children;
  MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Container(
          
          width: double.infinity,
          height: height,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.spaceBetween,
              
              children: children,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}