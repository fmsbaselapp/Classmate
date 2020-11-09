import 'package:Classmate/services/services.dart';
import 'package:Classmate/ui/shared/export.dart';
import 'package:Classmate/viewmodels/viewmodels.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ErstellenView extends StatelessWidget {
  const ErstellenView({@required this.title, Key key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ErstellenViewModel>.reactive(
        disposeViewModel: false,
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
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: ErstellenAppBar(
                            title: model.getTitle(title),
                            color: model.getColor(title)),
                      ),
                      SliverPadding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        sliver: SliverList(
                          delegate: SliverChildListDelegate(
                            [
                              SizedBox(
                                height: 30,
                              ),
                              ErstellenTextField(title: true),
                              ErstellenFaecherAuswahl(),
                              ErstellenDatumAuswahl(),
                              ErstellenTextField(title: false),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
        viewModelBuilder: () => locator<ErstellenViewModel>());
  }
}

class ErstellenDatumAuswahl extends StatelessWidget {
  const ErstellenDatumAuswahl({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2020, 9, 7, 17, 30),
          lastDate: DateTime(2020, 10, 7, 17, 30),
        );
      },
      child: Text('Datum'),
    );
  }
}
