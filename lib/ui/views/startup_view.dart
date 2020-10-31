import 'package:Classmate/viewmodels/viewmodels.dart';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class StartupView extends StatelessWidget {
  const StartupView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartupViewModel>.reactive(
      viewModelBuilder: () => StartupViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: FlatButton(
            onPressed: () {},
            child: Text(
              model.isBusy.toString(),
            ),
          ),
        ),
      ),
    );
  }
}
