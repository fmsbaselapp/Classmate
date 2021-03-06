import 'package:Classmate/app/locator.dart';
import 'package:Classmate/ui/shared/export.dart';
import 'package:Classmate/ui/views/uebersicht/uebersicht_viewmodel.dart';
import 'package:Classmate/ui/views/views.dart';
import 'package:Classmate/ui/widgets/home_container.dart';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class UebersichtView extends StatelessWidget {
  const UebersichtView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UebersichtViewModel>.reactive(
        //NONREACTIVE!
        // 1 dispose viewmodel
        disposeViewModel: false,
        // 3. set initialiseSpecialViewModelsOnce to true to indicate only initialising once
        initialiseSpecialViewModelsOnce: true,
        builder: (context, model, child) => Scaffold(
              body: SafeArea(
                child: CustomScrollView(
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  key: PageStorageKey('Home_Column_Key'),
                  slivers: [
                    CustomAppBar(
                      title: 'Übersicht',
                      onPressed: () {},
                    ),
                    SliverPadding(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      sliver: SliverToBoxAdapter(
                        child: SizedBox(
                          height: 145.0,
                          child: FaecherHomeView(),
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.only(left: 15, right: 15, bottom: 20),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            // To convert this infinite list to a list with three items,
                            // uncomment the following line:
                            // if (index > 3) return null;
                            const List title = ['Infos', 'Aufgaben', 'Tests'];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: HomeContainer(
                                title: title[index],
                              ),
                            );
                          },
                          // Or, uncomment the following line:
                          childCount: 3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        viewModelBuilder: () => locator<UebersichtViewModel>());
  }
}
