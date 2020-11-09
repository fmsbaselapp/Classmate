import 'package:Classmate/models/models.dart';
import 'package:Classmate/services/services.dart';
import 'package:Classmate/ui/shared/fachUI.dart';
import 'package:Classmate/viewmodels/viewmodels.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ErstellenFaecherAuswahl extends StatelessWidget {
  const ErstellenFaecherAuswahl({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FaecherViewModel>.reactive(
        // 1 dispose viewmodel
        disposeViewModel: false,
        // 3. set initialiseSpecialViewModelsOnce to true to indicate only initialising once
        initialiseSpecialViewModelsOnce: true,
        builder: (context, model, child) => model.hasData
            ? ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: model.faecher.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 15,
                  );
                },
                itemBuilder: (BuildContext context, int index) {
                  Fach fach = model.faecher[index];
                  return FachUI(
                    fach: fach.name,
                    zeit: fach.zeit,
                    raum: fach.raum,
                    icon: fach.icon,
                    farbe: fach.farbe,
                  );
                },
              )
            : Center(
                //TODO: Loading
                child: Container(
                  height: 1000,
                  color: Colors.blue,
                  child: Text('Keine Daten'),
                ),
              ),
        viewModelBuilder: () => locator<FaecherViewModel>());
  }
}
