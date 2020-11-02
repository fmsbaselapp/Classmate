import 'package:Classmate/app/locator.dart';
import 'package:Classmate/models/models.dart';
import 'package:Classmate/ui/views/aufgabenHome_view.dart';
import 'package:Classmate/ui/views/views.dart';
import 'package:Classmate/viewmodels/uebersicht_viewmodel.dart';

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
                        child: FaecherHomeView(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),

                            /*                 HomeContainer(
                              type: '',
                              title: 'Info',
                              list: [],
                              // onPressed:
                              //Listview
                              // widgets: InfoBig(),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            AufgabenHomeView(),
                            const SizedBox(
                              height: 30,
                            ),
                            HomeContainer(
                              type: '',
                              list: [],
                              // onPressed:
                              //Listview
                              title: 'Tests',
                              //  widgets: TestBig(),
                            ),*/
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
