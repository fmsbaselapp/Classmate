import 'package:Classmate/app/locator.dart';
import 'package:Classmate/ui/shared/export.dart';
import 'package:Classmate/ui/views/home/home_viewmodel.dart';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CalendarView extends StatelessWidget {
  const CalendarView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.nonReactive(
        // 1 dispose viewmodel
        disposeViewModel: false,
        // 3. set initialiseSpecialViewModelsOnce to true to indicate only initialising once
        initialiseSpecialViewModelsOnce: true,
        builder: (context, model, child) {
          return Scaffold(
            body: SafeArea(
              child: CustomScrollView(
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                key: PageStorageKey('Kalendar_Column_Key'),
                slivers: [
                  CustomAppBar(
                    title: 'Kalender',
                    onPressed: () {},
                  ),
                  SliverToBoxAdapter(
                    child: Center(
                      child: Text('Kalender'),
                    ),
                  )
                ],
              ),
            ),
          );
        },
        viewModelBuilder: () => locator<HomeViewModel>());
  }
}
