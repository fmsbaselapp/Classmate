import 'package:Classmate/services/services.dart';
import 'package:Classmate/ui/shared/export.dart';
import 'package:Classmate/viewmodels/viewmodels.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ErstellenView extends StatelessWidget {
  const ErstellenView({@required this.title, Key key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ErstellenViewModel>.nonReactive(
        disposeViewModel: false,
        //initialiseSpecialViewModelsOnce: false,
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
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onPanDown: (_) {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: CustomScrollView(
                      controller: scrollController,
                      slivers: [
                        SliverPersistentHeader(
                          pinned: true,
                          delegate: ErstellenAppBar(
                              title: title, color: model.getColor(title)),
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
                                ErstellenDatumAuswahl(),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
        viewModelBuilder: () => locator<ErstellenViewModel>());
  }
}

class ErstellenDatumAuswahl extends ViewModelBuilderWidget<ErstellenViewModel> {
  const ErstellenDatumAuswahl({Key key}) : super(key: key);

  @override
  Widget builder(BuildContext context, ErstellenViewModel model, Widget child) {
    return DatePicker(
      DateTime.now(),
      initialSelectedDate: DateTime.now(),
      selectionColor: Theme.of(context).indicatorColor,
      selectedTextColor: Colors.white,
      onDateChange: (date) {
        model.dateSelect(date);
        // New date selected
      },
    );
  }

  @override
  ErstellenViewModel viewModelBuilder(BuildContext context) =>
      ErstellenViewModel();
}
