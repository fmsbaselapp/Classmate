import 'package:Classmate/app/locator.dart';
import 'package:Classmate/ui/views/viewmodels.dart';
import 'package:Classmate/ui/views/views.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class InfosHomeView extends StatelessWidget {
  const InfosHomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<InfosViewModel>.reactive(
        disposeViewModel: false,
        initialiseSpecialViewModelsOnce: true,
        builder: (context, model, child) => model.hasData
            ? ListView.separated(
                shrinkWrap: true,
                key: PageStorageKey('Infos_Home_Key'),
                physics: NeverScrollableScrollPhysics(),
                itemCount: model.infos.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 15,
                  );
                },
                itemBuilder: (BuildContext context, int index) {
                  return ContentPanelView(
                    content: model.infos[index],
                    index: index,
                    isInfo: true,
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
        viewModelBuilder: () => locator<InfosViewModel>());
  }
}
