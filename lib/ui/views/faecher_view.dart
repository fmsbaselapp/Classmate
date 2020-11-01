import 'package:Classmate/app/locator.dart';
import 'package:Classmate/models/models.dart';
import 'package:Classmate/ui/widgets/home_stunden.dart';
import 'package:Classmate/viewmodels/viewmodels.dart';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class FaecherView extends StatelessWidget {
  const FaecherView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FaecherViewModel>.reactive(

        // 1 dispose viewmodel
        disposeViewModel: false,
        // 3. set initialiseSpecialViewModelsOnce to true to indicate only initialising once
        initialiseSpecialViewModelsOnce: true,
        builder: (context, model, child) => Scaffold(
              body: model.hasData
                  ? ListView.builder(
                      itemCount: model.faecher.length,
                      itemBuilder: (BuildContext context, int index) {
                        Fach fach = model.faecher[index];
                        return HomeStunden(
                          fach: fach.name,
                          zeit: fach.zeit,
                          raum: fach.raum,
                          icon: fach.icon,
                          farbe: fach.farbe,
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
            ),
        viewModelBuilder: () => locator<FaecherViewModel>());
  }
}
