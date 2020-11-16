import 'package:Classmate/models/models.dart';
import 'package:Classmate/services/services.dart';
import 'package:Classmate/ui/shared/export.dart';
import 'package:Classmate/ui/views/viewmodels.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ErstellenFaecherAuswahlView extends StatelessWidget {
  const ErstellenFaecherAuswahlView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.nonReactive(
        builder: (context, model, child) => Container(
              decoration: BoxDecoration(
                color: Theme.of(context).highlightColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: model.hasData
                  ? ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: model.faecher.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                      itemBuilder: (BuildContext context, int index) {
                        Fach fach = model.faecher[index];
                        return InkWell(
                          onTap: () {
                            model.fachSelect(fach);
                          },
                          child: FachUIerstellen(
                            fach: fach.name,
                            icon: fach.icon,
                            farbe: fach.farbe,
                          ),
                        );
                      },
                    )
                  : Wrap(),
            ),
        viewModelBuilder: () => locator<ErstellenViewModel>());
  }
}
