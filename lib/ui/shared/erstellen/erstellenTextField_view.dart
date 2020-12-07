import 'package:Classmate/services/services.dart';
import 'package:Classmate/ui/views/viewmodels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

class ErstellenTextField extends StatelessWidget {
  const ErstellenTextField({@required this.title, Key key}) : super(key: key);
  final bool title;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ErstellenViewModel>.nonReactive(
        disposeViewModel: false,
        initialiseSpecialViewModelsOnce: true,
        builder: (context, model, child) => ErstellenTextFieldHookWidget(
              title: title,
            ),
        viewModelBuilder: () => locator<ErstellenViewModel>());
  }
}

class ErstellenTextFieldHookWidget
    extends HookViewModelWidget<ErstellenViewModel> {
  const ErstellenTextFieldHookWidget({
    @required this.title,
    this.inititalText,
    Key key,
  }) : super(
          key: key,
          reactive: false,
        );

  final String inititalText;
  final bool title;

  @override
  Widget buildViewModelWidget(BuildContext context, ErstellenViewModel model) {
    //print('Build TextField $title');

    var text = useTextEditingController(
        text: title ? model.initialTitle : model.initialNotiz);

    return TextField(
      //TODO: autofillHints: ,

      onChanged: title ? model.updateTitle : model.updateNotiz,

      controller: text,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      autofocus: false, //TODO:
      minLines: title ? null : 4,
      maxLines: null,
      style: title
          ? Theme.of(context).textTheme.headline2
          : Theme.of(context).textTheme.bodyText1,
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
