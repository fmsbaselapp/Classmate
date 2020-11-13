import 'package:Classmate/models/models.dart';
import 'package:Classmate/services/services.dart';
import 'package:Classmate/ui/shared/export.dart';
import 'package:Classmate/ui/views/viewmodels.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class FaecherDetailView extends StatelessWidget {
  const FaecherDetailView({Key key, @required this.fach, this.index})
      : super(key: key);

  final Fach fach;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FaecherViewModel>.nonReactive(
        // 1 dispose viewmodel
        disposeViewModel: false,
        // 3. set initialiseSpecialViewModelsOnce to true to indicate only initialising once
        initialiseSpecialViewModelsOnce: true,
        builder: (context, model, child) => DraggableScrollableSheet(
              expand: false,
              initialChildSize: 0.95,
              minChildSize: 0.85,
              maxChildSize: 0.95,
              builder: (context, scrollController) {
                return ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(20.0),
                    topRight: const Radius.circular(20.0),
                  ),
                  child: CustomScrollView(
                    controller: scrollController,
                    slivers: [
                      SliverPadding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        sliver: SliverList(
                          delegate: SliverChildListDelegate(
                            [
                              SizedBox(
                                height: 30,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Hero(
                                tag: fach.name + index.toString(),
                                child: FachUI(
                                  fach: fach.name,
                                  zeit: fach.zeit,
                                  raum: fach.raum,
                                  icon: fach.icon,
                                  farbe: fach.farbe,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
        viewModelBuilder: () => locator<FaecherViewModel>());
  }
}
