import 'package:Classmate/app/locator.dart';
import 'package:Classmate/viewmodels/viewmodels.dart';

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
              body: Center(
                child: Text(model.name),
              ),
            ),
        viewModelBuilder: () => locator<FaecherViewModel>());
  }
}
