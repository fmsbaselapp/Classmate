import 'package:Classmate/app/locator.dart';
import 'package:Classmate/ui/shared/test.dart';
import 'package:Classmate/ui/views/viewmodels.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class TestsHomeView extends StatelessWidget {
  const TestsHomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TestsViewModel>.reactive(
        disposeViewModel: false,
        initialiseSpecialViewModelsOnce: true,
        builder: (context, model, child) => model.hasData
            ? ListView.separated(
                shrinkWrap: true,
                key: PageStorageKey('Test_Home_Key'),
                physics: NeverScrollableScrollPhysics(),
                itemCount: model.tests.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    width: 15,
                  );
                },
                itemBuilder: (BuildContext context, int index) {
                  return TestBig(
                    test: model.tests[index],
                  );
                },
              )
            : Center(
                //TODO: Loading
                child: Container(
                  height: 100,
                  color: Colors.black,
                  child: Text('Keine Daten'),
                ),
              ),
        viewModelBuilder: () => locator<TestsViewModel>());
  }
}
