import 'package:Classmate/viewmodels/viewmodels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

class ErstellenTextField extends HookViewModelWidget<ErstellenViewModel> {
  const ErstellenTextField({
    @required this.title,
    Key key,
  }) : super(
          key: key,
          reactive: false,
        );

  final bool title;

  @override
  Widget buildViewModelWidget(BuildContext context, ErstellenViewModel model) {
    var text = useTextEditingController();
    return TextField(
      //TODO: autofillHints: ,
      onChanged: model.updateTitle,
      controller: text,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      autofocus: true,
      minLines: title ? null : 4,
      maxLines: null,
      style: Theme.of(context).textTheme.headline2,
      textAlignVertical: TextAlignVertical.top,

      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(
          left: 15,
          right: 15,
          top: 30,
        ),
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
