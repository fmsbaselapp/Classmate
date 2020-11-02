import 'package:Classmate/app/locator.dart';
import 'package:Classmate/models/models.dart';
import 'package:Classmate/ui/widgets/home_container.dart';
import 'package:Classmate/ui/widgets/home_stunden.dart';
import 'package:Classmate/viewmodels/aufgaben_viewmodel.dart';
import 'package:Classmate/viewmodels/viewmodels.dart';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AufgabenHomeView extends StatelessWidget {
  const AufgabenHomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AufgabenViewModel>.reactive(

        // 1 dispose viewmodel
        disposeViewModel: false,
        // 3. set initialiseSpecialViewModelsOnce to true to indicate only initialising once
        initialiseSpecialViewModelsOnce: true,
        builder: (context, model, child) => Scaffold(
              body: model.hasData
                  ? HomeContainer(
                      title: 'Aufgaben', type: 'aufgaben', list: model.aufgaben)
                  : Center(
                      //TODO: Loading
                      child: Container(
                        height: 1000,
                        color: Colors.blue,
                        child: Text('Keine Daten'),
                      ),
                    ),
            ),
        viewModelBuilder: () => locator<AufgabenViewModel>());
  }
}
