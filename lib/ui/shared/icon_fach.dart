import 'package:flutter/material.dart';

class IconFach extends StatelessWidget {
  IconFach({
    this.size,
    @required this.farbe,
    @required this.icon,
    Key key,
  }) : super(key: key);

  final String icon;
  final int farbe;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: size ?? 40,
          height: size ?? 40,
          decoration: BoxDecoration(
            color: Color(farbe).withOpacity(0.3),
            shape: BoxShape.circle,
          ),
        ),
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
              color: Color(farbe).withOpacity(1), shape: BoxShape.circle),
        ),
        Text(
          icon ?? '',
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
