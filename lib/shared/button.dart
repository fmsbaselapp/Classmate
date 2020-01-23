import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class SmallButton extends StatelessWidget {
  SmallButton({@required this.onPressed, this.child, this.elevation});
  GestureTapCallback onPressed;
  var child;
  var elevation;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      splashColor: Colors.grey,
      fillColor: Theme.of(context).primaryColor,
      shape: const StadiumBorder(),
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
      elevation: elevation ?? 10,
      highlightElevation: 0,
      child: child,
      textStyle: Theme.of(context).textTheme.button,
      onPressed: onPressed,
    );
  }
}

class SmallButtonDark extends StatelessWidget {
  SmallButtonDark({@required this.onPressed, this.child, this.elevation});
  GestureTapCallback onPressed;
  var child;
  var elevation;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      splashColor: Colors.grey,
      fillColor: Color(0xff454545),
      shape: const StadiumBorder(),
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
      elevation: elevation ?? 10,
      highlightElevation: 0,
      child: child,
      textStyle:
          Theme.of(context).textTheme.button.copyWith(color: Colors.white),
      onPressed: onPressed,
    );
  }
}

class SmallButtonLight extends StatelessWidget {
  SmallButtonLight({@required this.onPressed, this.child, this.elevation});
  GestureTapCallback onPressed;
  var child;
  var elevation;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      splashColor: Colors.grey,
      fillColor: Colors.white,
      shape: const StadiumBorder(),
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
      elevation: elevation ?? 10,
      highlightElevation: 0,
      child: child,
      textStyle:
          Theme.of(context).textTheme.button.copyWith(color: Colors.black),
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
      fillColor: getColor(),
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
    }
  }
}

class RoundButton extends StatelessWidget {
  RoundButton({@required this.onPressed, this.child});
  GestureTapCallback onPressed;
  var child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 40,
      child: RawMaterialButton(
        splashColor: Colors.grey,
        fillColor: Theme.of(context).primaryColor,
        shape: const StadiumBorder(),
        elevation: 10,
        highlightElevation: 0,
        child: child,
        textStyle: Theme.of(context).textTheme.button,
        onPressed: onPressed,
      ),
    );
  }
}

class LableButtonExtended extends StatelessWidget {
  LableButtonExtended(
      {@required this.onPressed,
      this.text,
      this.child,
      this.color,
      this.paddingTop,
      this.paddingBottom,
      this.paddingLeft,
      this.paddingRight});
  GestureTapCallback onPressed;
  String text;
  var child;
  var color;
  double paddingTop;
  double paddingBottom;
  double paddingLeft;
  double paddingRight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: paddingTop ?? 0,
          bottom: paddingBottom ?? 0,
          left: paddingLeft ?? 0,
          right: paddingRight ?? 0),
      child: SizedBox(
        width: double.infinity,
        child: RawMaterialButton(
          splashColor: Colors.grey,
          fillColor: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(15.0)),
          padding: EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
          elevation: 5,
          highlightElevation: 0,
          child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[if (text != null) Text(text) else child],
              )),
          textStyle: Theme.of(context).textTheme.button,
          onPressed: onPressed,
        ),
      ),
    );
  }
}
