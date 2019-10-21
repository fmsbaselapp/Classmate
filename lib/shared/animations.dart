import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class FadeIn extends StatefulWidget {
  FadeIn({@required this.child});
  var child;
  _FadeInState createState() => _FadeInState();
}

class _FadeInState extends State<FadeIn> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animation;

  initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();
  }

  Widget build(BuildContext context) {
    return FadeTransition(opacity: animation, child: widget.child);
  }
  
  @override
  void dispose() {
  _controller.dispose();
  super.dispose();
}
}
