import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class SmallButton extends StatelessWidget {
  SmallButton({@required this.onPressed, this.child} );
  GestureTapCallback onPressed;
  var child;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      splashColor: Colors.grey,
      fillColor: Colors.white,
      shape: const StadiumBorder(),
      padding: EdgeInsets.only(top: 10, bottom: 10,left: 20,right: 20),
      elevation: 9,
      highlightElevation: 0,
      child: child,
      textStyle: Theme.of(context).textTheme.button,
      onPressed: onPressed,
    );
  }
}
