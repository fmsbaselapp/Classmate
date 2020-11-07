import 'package:Classmate/app/locator.dart';
import 'package:Classmate/ui/shared/aufgabe.dart';
import 'package:Classmate/viewmodels/aufgaben_viewmodel.dart';

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
                    width: 15,
                  );
                },
                itemBuilder: (BuildContext context, int index) {
                  return AufgabeBig(
                    aufgabe: model.aufgaben[index],
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
