import 'package:Classmate/app/locator.dart';
import 'package:Classmate/ui/shared/export.dart';
import 'package:Classmate/ui/views/home/home_viewmodel.dart';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class NotenView extends StatelessWidget {
  const NotenView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.nonReactive(
        // 1 dispose viewmodel
        disposeViewModel: false,
        // 3. set initialiseSpecialViewModelsOnce to true to indicate only initialising once
        initialiseSpecialViewModelsOnce: true,
        builder: (context, model, child) => Scaffold(
              body: SafeArea(
                child: CustomScrollView(
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  key: PageStorageKey('Noten_Column_Key'),
                  slivers: [
                    CustomAppBar(
                      title: 'Noten',
                      onPressed: () {},
                    ),
                    SliverToBoxAdapter(
                      child: Center(
                        child: Text('Noten'),
                      ),
                    )
                  ],
                ),
              ),
            ),
        viewModelBuilder: () => locator<HomeViewModel>());
  }
}
