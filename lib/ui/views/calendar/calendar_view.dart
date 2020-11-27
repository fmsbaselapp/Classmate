import 'package:Classmate/app/locator.dart';
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
              body: Center(
            child: Text('Calender'),
          ));
        },
        viewModelBuilder: () => locator<HomeViewModel>());
  }
}
