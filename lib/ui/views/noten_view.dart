import 'package:Classmate/core/viewmodels/home_viewmodel.dart';

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
              body: Center(
                child: Text('Noten'),
              ),
            ),
        viewModelBuilder: () => HomeViewModel());
  }
}
