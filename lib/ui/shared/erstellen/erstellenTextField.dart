import 'package:flutter/material.dart';

class ErstellenTextField extends StatelessWidget {
  const ErstellenTextField({
    @required this.title,
    Key key,
  }) : super(key: key);

  final bool title;

  @override
  Widget build(BuildContext context) {
    return TextField(
      //TODO: autofillHints: ,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      autofocus: true,
      minLines: title ? null : 4,
      maxLines: null,
      style: Theme.of(context).textTheme.headline2,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
        filled: true,
        fillColor: Theme.of(context).highlightColor,
        focusColor: Theme.of(context).indicatorColor,
        hintText: title ? 'Titel' : 'Notiz hinzufügen',
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(15.0),
          ),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(15.0),
            ),
            borderSide:
                BorderSide(color: Theme.of(context).indicatorColor, width: 3)),
        enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(15.0),
            ),
            borderSide: BorderSide.none),
        errorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(15.0),
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(15.0),
          ),
        ),
      ),
    );
  }
}
