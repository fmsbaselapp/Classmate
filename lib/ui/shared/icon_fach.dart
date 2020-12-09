import 'package:flutter/material.dart';

class IconFach extends StatelessWidget {
  IconFach({
    @required this.size,
    @required this.farbe,
    @required this.icon,
    Key key,
  }) : super(key: key);

  final String icon;
  final int farbe;

  final double size;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: Color(farbe).withOpacity(0.3),
              shape: BoxShape.circle,
            ),
          ),
          Container(
            width: size / 1.35,
            height: size / 1.35,
            decoration: BoxDecoration(
                color: Color(farbe).withOpacity(1), shape: BoxShape.circle),
            child: Container(
              alignment: Alignment.center,
              child: Text(
                icon ?? '',
                //   '🤯',
                style: TextStyle(fontSize: 8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
