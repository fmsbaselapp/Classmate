import 'package:Classmate/models/models.dart';
import 'package:Classmate/services/services.dart';

import 'package:Classmate/ui/views/faecher/faecherAppBar.dart';
import 'package:Classmate/ui/views/viewmodels.dart';
import 'package:Classmate/ui/widgets/home_container.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class FaecherDetailView extends StatelessWidget {
  const FaecherDetailView({
    Key key,
    @required this.fach,
    @required this.index,
    @required this.heroContainer,
    @required this.heroPage,
    @required this.heroTitle,
    @required this.heroPop,
    @required this.heroDetails,
    //@required this.heroButtonRight,
  }) : super(key: key);

  final Fach fach;
  final int index;

  final String heroContainer;
  final String heroPage;
  final String heroTitle;
  final String heroPop;
  final String heroDetails;
  // final String heroButtonRight;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FaecherViewModel>.nonReactive(
        disposeViewModel: false,
        initialiseSpecialViewModelsOnce: true,
        onModelReady: (model) => model.initialize(
              fach,
            ),
        builder: (context, model, child) {
          //model.faecherAuswahlShow();

          // backgroundColor: Theme.of(context).accentColor,
          return NotificationListener<DraggableScrollableNotification>(
            onNotification: (sheet) {
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
                        flightShuttleBuilder: (flightContext, animation,
                            flightDirection, fromHeroContext, toHeroContext) {
                          final Hero toHero = toHeroContext.widget;
                          return FadeTransition(
                            opacity: animation.drive(
                              Tween<double>(begin: 0.0, end: 1.0).chain(
                                CurveTween(
                                  curve: Interval(0.0, 0.2,
                                      curve: Curves.easeInExpo),
                                ),
                              ),
                            ),
                            child: toHero,
                          );
                        },
                        child: _FaecherOpenView(
                          fach: fach,
                          scrollController: scrollController,
                        ),
                      ),
                      CustomScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        slivers: [
                          SliverPersistentHeader(
                            pinned: true,
                            delegate: FaecherAppBar(
                              heroContainer: heroContainer,
                              heroTitle: heroTitle,
                              heroPop: heroPop,
                              heroDetails: heroDetails,
                              fach: fach,
                              // heroButtonRight: heroButtonRight,
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
        viewModelBuilder: () => locator<FaecherViewModel>());
  }
}

class _FaecherOpenView extends StatelessWidget {
  const _FaecherOpenView({
    Key key,
    @required this.fach,
    @required this.scrollController,
    this.title,
  }) : super(key: key);

  final Fach fach;
  final ScrollController scrollController;

  final String title;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ErstellenViewModel>.reactive(
        disposeViewModel: false,
        //initialiseSpecialViewModelsOnce: true,
        builder: (context, model, child) => Opacity(
              opacity: 1.0,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(20.0),
                      topRight: const Radius.circular(20.0),
                    ),
                    color: Theme.of(context).accentColor,
                  ),
                  height: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(20.0),
                      topRight: const Radius.circular(20.0),
                    ),
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onPanDown: (_) {
                        FocusScope.of(context).unfocus();
                      },
                      child: CustomScrollView(
                        shrinkWrap: false,
                        physics: BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        controller: //scrollController,
                            model.dismissSheet ? scrollController : null,
                        slivers: [
                          SliverPadding(
                            padding: EdgeInsets.only(
                                left: 15, right: 15, top: 70, bottom: 15),
                            sliver: SliverList(
                              delegate: SliverChildListDelegate(
                                [
                                  SizedBox(
                                    height: 30,
                                  ),

                                  // HomeContainer(title: 'Infos'),

                                  /*  !neu
                                      ? ContainerWidget(
                                          child: ErstellenDelete( fach: fach,))
                                      : Wrap(), */
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
        viewModelBuilder: () => locator<ErstellenViewModel>());
  }
}
