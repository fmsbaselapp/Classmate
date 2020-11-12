import 'package:Classmate/services/services.dart';
import 'package:Classmate/viewmodels/viewmodels.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ViewForTesting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ErstellenViewModel>.nonReactive(
        disposeViewModel: false,
        //initialiseSpecialViewModelsOnce: true,
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: Text('title'),
              ),
              body: DraggableScrollableSheet(
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
                            SliverToBoxAdapter(
                              child: Container(
                                color: Colors.blue,
                                height: 100,
                              ),
                            )
                          ]),
                    ),
                  );
                },
              ),
            ),
        viewModelBuilder: () => locator<ErstellenViewModel>());
  }
}
