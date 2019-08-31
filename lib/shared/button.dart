import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class SmallButton extends StatelessWidget {
  SmallButton({@required this.onPressed, this.child});
  GestureTapCallback onPressed;
  var child;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      splashColor: Colors.grey,
      fillColor: Colors.white,
      shape: const StadiumBorder(),
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
      elevation: 10,
      highlightElevation: 0,
      child: child,
      textStyle: Theme.of(context).textTheme.button,
      onPressed: onPressed,
    );
  }
}

class LableButton extends StatelessWidget {
  LableButton({@required this.onPressed, this.child, this.color});
  GestureTapCallback onPressed;
  var child;
  var color;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      splashColor: Colors.grey,
      fillColor:  getColor(),
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
      padding: EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
      elevation: 10,
      highlightElevation: 0,
      child: child,
      textStyle: Theme.of(context).textTheme.button,
      onPressed: onPressed,
    );
  }

  //button color
  Color getColor() {
  if (color != null) {
    return color;
  } else {
    return Colors.white;
  }}
}

