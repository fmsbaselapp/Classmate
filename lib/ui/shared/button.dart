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

class AufgabeButton extends StatelessWidget {
  const AufgabeButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      child: RawMaterialButton(
        fillColor: Theme.of(context).indicatorColor,
        shape: CircleBorder(),
        onPressed: () {},
        child: Icon(
          Icons.check_rounded,
          size: 25,
          color: Theme.of(context).primaryColorLight,
        ),
      ),
    );
  }
}

class TextButtonCustom extends StatelessWidget {
  const TextButtonCustom(
      {@required this.onPressed, @required this.text, Key key})
      : super(key: key);

  final Function onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      child: RawMaterialButton(
        fillColor: Theme.of(context).indicatorColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: onPressed,
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }
}
