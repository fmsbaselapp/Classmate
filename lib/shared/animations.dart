import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class FadeIn extends StatefulWidget {
  FadeIn({@required this.child});
  var child;
  _FadeInState createState() => _FadeInState();
}

class _FadeInState extends State<FadeIn> with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    controller.forward();
  }

  Widget build(BuildContext context) {
    return FadeTransition(opacity: animation, child: widget.child);
  }
}
