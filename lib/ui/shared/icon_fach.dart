import 'package:flutter/material.dart';

class IconFach extends StatelessWidget {
  IconFach({
    this.size,
    Key key,
  }) : super(key: key);

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
            color: Color.fromRGBO(170, 255, 180, 0.3),
            shape: BoxShape.circle,
          ),
        ),
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
              color: Color.fromRGBO(170, 255, 180, 1), shape: BoxShape.circle),
        ),
        Text(
          '🌱',
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
