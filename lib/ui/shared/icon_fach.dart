import 'package:flutter/material.dart';

class IconFach extends StatelessWidget {
  IconFach({
    @required this.small,
    @required this.farbe,
    @required this.icon,
    Key key,
  }) : super(key: key);

  final String icon;
  final int farbe;
  final bool small;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: small ? 17 : 30,
            height: small ? 17 : 30,
            decoration: BoxDecoration(
              color: Color(farbe).withOpacity(0.3),
              shape: BoxShape.circle,
            ),
          ),
          Container(
            width: small ? 13 : 20,
            height: small ? 13 : 20,
            decoration: BoxDecoration(
                color: Color(farbe).withOpacity(1), shape: BoxShape.circle),
          ),
          Text(
            icon ?? '',
            style: TextStyle(fontSize: small ? 7 : 15),
          ),
        ],
      ),
    );
  }
}
