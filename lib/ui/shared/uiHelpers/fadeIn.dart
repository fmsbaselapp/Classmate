import 'package:flutter/material.dart';

//TODO: Needed?
class FadeIn extends StatefulWidget {
  FadeIn({@required this.child});

  var child;

  _FadeInState createState() => _FadeInState();
}

class _FadeInState extends State<FadeIn> with TickerProviderStateMixin {
  Animation<double> animation;

  AnimationController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
}
