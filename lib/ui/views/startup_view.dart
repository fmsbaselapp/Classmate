import 'package:Classmate/core/viewmodels/home_viewmodel.dart';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class StartupView extends StatelessWidget {
  const StartupView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.nonReactive(
        builder: (context, model, child) => Scaffold(),
        viewModelBuilder: () => HomeViewModel());
  }
}
