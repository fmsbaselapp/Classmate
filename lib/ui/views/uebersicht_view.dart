import 'package:Classmate/app/locator.dart';
import 'package:Classmate/models/models.dart';
import 'package:Classmate/viewmodels/uebersicht_viewmodel.dart';

import 'package:Classmate/ui/shared/export.dart';
import 'package:Classmate/ui/widgets/export.dart';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class UebersichtView extends StatelessWidget {
  const UebersichtView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UebersichtViewModel>.reactive(
        // 1 dispose viewmodel
        disposeViewModel: false,
        // 3. set initialiseSpecialViewModelsOnce to true to indicate only initialising once
        initialiseSpecialViewModelsOnce: true,
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: Text('Übersicht'),
              ),
              body: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  key: PageStorageKey('Home_Column_Key'),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 145.0,
                        /*child: 
                        ListView.separated(
                            key: PageStorageKey('Home_Faecher_Key'),
                            scrollDirection: Axis.horizontal,
                            itemCount: model.length + 2,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(
                                width: 15,
                              );
                            },
                            itemBuilder: (BuildContext context, int index) {
                             
                         
                            //if (index == 0 || index == items.length + 1) {
                            if (index == 0) {
                              return Wrap();
                            }
                            return HomeStunden(
                              fach: model.title,
                              zeit: model.zeit,
                              raum: model.raum,
                            );
                          },
                            ),
                            */
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            HomeContainer(
                              title: 'Info',
                              //Listview
                              widgets: InfoBig(),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            HomeContainer(
                              title: 'Aufgaben',
                              //Listview
                              widgets: AufgabeBig(
                                aufgabe: Aufgabe(
                                  datum: 'Freitag, 31 Januar',
                                  titel: 'Hallo',
                                  fach: Fach(name: 'Biologie'),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            HomeContainer(
                              //Listview
                              title: 'Tests',
                              widgets: TestBig(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        viewModelBuilder: () => locator<UebersichtViewModel>());
  }
}
