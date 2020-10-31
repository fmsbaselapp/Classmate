import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  RoundButton(
      {@required this.icon, @required this.onPressed, this.iconSize, Key key})
      : super(key: key);

  final IconData icon;
  final double iconSize;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      child: RawMaterialButton(
        elevation: 5.0,
        fillColor: Theme.of(context).indicatorColor,
        shape: CircleBorder(),
        onPressed: onPressed,
        child: Icon(
          icon,
          size: iconSize ?? 25,
          color: Theme.of(context).primaryColorLight,
        ),
      ),
    );
  }
}
