import 'package:Classmate/models/models.dart';
import 'package:Classmate/services/services.dart';
import 'package:Classmate/ui/shared/export.dart';
import 'package:Classmate/ui/views/erstellen/erstellen_viewmodel.dart';

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ErstellenView extends StatelessWidget {
  const ErstellenView({
    @required this.title,
    this.aufgabe,
    this.heroContainer,
    this.heroTitle,
    this.heroPage,
    this.heroPop,
    this.index,
    Key key,
  }) : super(key: key);

  final Aufgabe aufgabe;
  final String heroContainer;
  final String heroPage;
  final String heroTitle;
  final String heroPop;

  final int index;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ErstellenViewModel>.nonReactive(
        disposeViewModel: false,
        //initialiseSpecialViewModelsOnce: true,
        builder: (context, model, child) {
          model.controllerInitialize();

          // backgroundColor: Theme.of(context).accentColor,
          return NotificationListener<DraggableScrollableNotification>(
            onNotification: (sheet) {
              print("${sheet.extent}");
              return model.controller(sheet);
            },
            child: DraggableScrollableActuator(
              child: DraggableScrollableSheet(
                initialChildSize: 0.95,
                minChildSize: 0.85,
                maxChildSize: 0.95,
                builder: (context, scrollController) {
                  return Stack(
                    children: [
                      Hero(
                        tag: heroPage,
                        child: Material(
                          child: Container(
                            color: Theme.of(context).accentColor,
                            height: double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(20.0),
                                topRight: const Radius.circular(20.0),
                              ),
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onPanDown: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                },
                                child: CustomScrollView(
                                  shrinkWrap: false,
                                  physics: BouncingScrollPhysics(
                                      parent: AlwaysScrollableScrollPhysics()),
                                  controller: scrollController,
                                  slivers: [
                                    SliverPadding(
                                      padding: EdgeInsets.only(
                                          left: 15,
                                          right: 15,
                                          top: 70,
                                          bottom: 15),
                                      sliver: SliverList(
                                        delegate: SliverChildListDelegate(
                                          [
                                            SizedBox(
                                              height: 30,
                                            ),
                                            ErstellenTextField(title: true),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            ErstellenFaecherAuswahlView(),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            ErstellenTextField(title: false),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            // ErstellenDatumAuswahl(),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      CustomScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        slivers: [
                          SliverPersistentHeader(
                            pinned: true,
                            delegate: ErstellenAppBar(
                              title: title,
                              color: model.getColor(title),
                              heroContainer: heroContainer,
                              heroTitle: heroTitle,
                              heroPop: heroPop,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        },
        viewModelBuilder: () => locator<ErstellenViewModel>());
  }
}

class ErstellenDatumAuswahl extends StatelessWidget {
  const ErstellenDatumAuswahl({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ErstellenViewModel>.nonReactive(
        builder: (context, model, child) => Container(
              child: Material(
                child: DatePicker(
                  DateTime.now(),
                  initialSelectedDate: DateTime.now(),
                  selectionColor: Theme.of(context).indicatorColor,
                  selectedTextColor: Colors.white,
                  onDateChange: (date) {
                    model.dateSelect(date);
                    // New date selected
                  },
                ),
              ),
            ),
        viewModelBuilder: () => locator<ErstellenViewModel>());
  }
}
