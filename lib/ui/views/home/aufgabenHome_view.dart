import 'package:Classmate/app/locator.dart';

import 'package:Classmate/ui/views/aufgaben/aufgaben_viewmodel.dart';
import 'package:Classmate/ui/views/views.dart';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AufgabenHomeView extends StatelessWidget {
  const AufgabenHomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AufgabenViewModel>.reactive(
        disposeViewModel: false,
        initialiseSpecialViewModelsOnce: true,
        builder: (context, model, child) => model.hasData
            ? ListView.separated(
                shrinkWrap: true,
                key: PageStorageKey('Aufgaben_Home_Key'),
                physics: NeverScrollableScrollPhysics(),
                itemCount: model.aufgaben.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 15,
                  );
                },
                itemBuilder: (BuildContext context, int index) {
                  return ContentPanelView(
                    index: index,
                    content: model.aufgaben[index],
                    isAufgabe: true,
                  );
                },
              )
            : Center(
                //TODO: Loading
                child: Container(
                  height: 1000,
                  color: Colors.blue,
                  child: Text('Keine Daten'),
                ),
              ),
        viewModelBuilder: () => locator<AufgabenViewModel>());
  }
}
