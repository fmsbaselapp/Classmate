import 'package:Classmate/app/locator.dart';
import 'package:Classmate/models/models.dart';
import 'package:Classmate/ui/shared/fachUI.dart';
import 'package:Classmate/viewmodels/viewmodels.dart';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class FaecherView extends StatelessWidget {
  const FaecherView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FaecherViewModel>.reactive(

        // 1 dispose viewmodel
        disposeViewModel: true,
        // 3. set initialiseSpecialViewModelsOnce to true to indicate only initialising once
        initialiseSpecialViewModelsOnce: false,
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: Text('Fächer'),
              ),
              body: SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 20),
                  child: model.hasData
                      ? ListView.separated(
                          itemCount: model.faecher.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              height: 15,
                            );
                          },
                          itemBuilder: (BuildContext context, int index) {
                            Fach fach = model.faecher[index];
                            return GestureDetector(
                              onTap: () {
                                model.navigateToDetailPage(
                                    fach, index, context);
                              },
                              child: FachUI(
                                fach: fach.name,
                                zeit: fach.zeit,
                                raum: fach.raum,
                                icon: fach.icon,
                                farbe: fach.farbe,
                              ),
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
              ),
            ),
        viewModelBuilder: () => locator<FaecherViewModel>());
  }
}
