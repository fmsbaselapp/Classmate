import 'package:Classmate/core/models/models.dart';
import 'package:Classmate/core/viewmodels/uebersicht_viewmodel.dart';

import 'package:Classmate/ui/shared/export.dart';
import 'package:Classmate/ui/widgets/export.dart';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class UebersichtView extends StatelessWidget {
  const UebersichtView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UebersichtViewModel>.nonReactive(
        // 1 dispose viewmodel
        disposeViewModel: false,
        // 3. set initialiseSpecialViewModelsOnce to true to indicate only initialising once
        initialiseSpecialViewModelsOnce: true,
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: Text('Übersicht'),
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 145.0,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: model.length + 2,
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            width: 15,
                          );
                        },
                        itemBuilder: (BuildContext context, int index) {
                          //if (index == 0 || index == items.length + 1) {
                          if (index == 0) {
                            return Wrap();
                          }
                          return Home_Stunden(
                            fach: model.title,
                            zeit: model.zeit,
                            raum: model.raum,
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Home_Container(
                            title: 'Info',
                            widgets: Info_Big(),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Home_Container(
                            title: 'Aufgaben',
                            widgets: Aufgabe_Big(
                              aufgabe: Aufgabe(
                                datum: 'Freitag, 31 Januar',
                                titel: 'Hallo',
                                fach: Fach(name: 'Biologie'),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Home_Container(
                            title: 'Tests',
                            widgets: Test_Big(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        viewModelBuilder: () => UebersichtViewModel());
  }
}
