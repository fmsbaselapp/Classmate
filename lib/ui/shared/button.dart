import 'package:Classmate/ui/views/erstellen/erstellen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

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
      height: 35,
      child: RawMaterialButton(
        fillColor: Theme.of(context).indicatorColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ),
    );
  }
}

class ContainerWidget extends StatelessWidget {
  const ContainerWidget({Key key, this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 15),
      decoration: BoxDecoration(
        color: Theme.of(context).highlightColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(0.00, 5.00),
            color: Color(0xff000000).withOpacity(0.10),
            blurRadius: 20,
          ),
        ],
        borderRadius: BorderRadius.circular(15),
      ),
      child: child,
    );
  }
}

class ErstellenFuerButton extends ViewModelBuilderWidget<ErstellenViewModel> {
  const ErstellenFuerButton({
    Key key,
  }) : super(key: key);

  @override
  Widget builder(BuildContext context, ErstellenViewModel model, Widget child) {
    return GestureDetector(
      onTap: () => model.fuerAlleChange(),
      child: Container(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Für alle erstellen',
              style: Theme.of(context).textTheme.headline2,
            ),
            SizedBox(
              height: 30,
              child: Switch.adaptive(
                activeColor: Theme.of(context).accentColor,
                value: model.isFuerAlle,
                onChanged: (val) => model.fuerAlleChange(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  ErstellenViewModel viewModelBuilder(BuildContext context) =>
      ErstellenViewModel();
}
