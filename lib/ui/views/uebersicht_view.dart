import 'package:Classmate/app/locator.dart';
import 'package:Classmate/ui/views/views.dart';
import 'package:Classmate/ui/widgets/home_container.dart';
import 'package:Classmate/viewmodels/uebersicht_viewmodel.dart';
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
              body: SafeArea(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: CustomScrollView(
                    physics: BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    key: PageStorageKey('Home_Column_Key'),
                    slivers: [
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
                        padding:
                            EdgeInsets.only(left: 15, right: 15, bottom: 20),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              // To convert this infinite list to a list with three items,
                              // uncomment the following line:
                              // if (index > 3) return null;
                              const List title = ['Info', 'Aufgabe', 'Test'];
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
            ),
        viewModelBuilder: () => locator<UebersichtViewModel>());
  }
}
