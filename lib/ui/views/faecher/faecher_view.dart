import 'package:Classmate/app/locator.dart';
import 'package:Classmate/models/models.dart';
import 'package:Classmate/ui/shared/export.dart';
import 'package:Classmate/ui/shared/fachUI.dart';
import 'package:Classmate/ui/views/viewmodels.dart';

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
              body: SafeArea(
                child: CustomScrollView(
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  key: PageStorageKey('Faecher_Column_Key'),
                  slivers: [
                    CustomAppBar(
                      title: 'Fächer',
                      onPressed: () {},
                    ),
                    SliverPadding(
                      padding: EdgeInsets.only(left: 15, right: 15, top: 20),
                      sliver: model.hasData
                          ? SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  Fach fach = model.faecher[index];
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 15),
                                    child: GestureDetector(
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
                                    ),
                                  );
                                },
                                childCount: model.faecher.length,
                              ),
                            )
                          : SliverToBoxAdapter(
                              child: Center(
                                //TODO: Loading
                                child: Container(
                                  height: 1000,
                                  color: Colors.blue,
                                  child: Text('Keine Daten'),
                                ),
                              ),
                            ),
                    )
                  ],
                ),
              ),
            ),
        viewModelBuilder: () => locator<FaecherViewModel>());
  }
}
