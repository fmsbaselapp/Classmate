import 'package:Classmate/services/services.dart';
import 'package:Classmate/ui/shared/export.dart';
import 'package:Classmate/ui/views/erstellen/erstellen_viewmodel.dart';

import 'package:Classmate/ui/views/viewmodels.dart';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ErstellenView extends StatelessWidget {
  ErstellenView({
    this.colorTitle,
    this.color,
    this.type,
    this.heroContainer,
    this.heroTitle,
    this.heroPage,
    this.heroPop,
    this.heroDetails,
    this.heroButtonRight,
    @required this.neu,
    this.title,
    Key key,
  }) : super(key: key);

  final dynamic type;
  final bool neu;
  final TextStyle colorTitle;
  final Color color;
  final String heroContainer;
  final String heroPage;
  final String heroTitle;
  final String heroPop;
  final String heroDetails;
  final String heroButtonRight;
  final String title;

  @override
  Widget build(BuildContext context) {
    print('Build: ErstellenView');
    return ViewModelBuilder<ErstellenViewModel>.nonReactive(
        disposeViewModel: false,
        initialiseSpecialViewModelsOnce: true,
        onModelReady: (model) => model.initialize(
              neu,
              type,
              title,
            ),
        builder: (context, model, child) {
          model.faecherAuswahlShow();

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
                      neu
                          ? _ContentErstellenView(
                              neu: neu,
                              type: type,
                              scrollController: scrollController,
                              title: title,
                            )
                          : Hero(
                              tag: heroPage,
                              flightShuttleBuilder: (flightContext,
                                  animation,
                                  flightDirection,
                                  fromHeroContext,
                                  toHeroContext) {
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
                              child: _ContentErstellenView(
                                neu: neu,
                                type: type,
                                scrollController: scrollController,
                              ),
                            ),
                      CustomScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        slivers: [
                          SliverPersistentHeader(
                            pinned: true,
                            delegate: ErstellenAppBar(
                                neu: neu,
                                type: type,
                                colorTitle: colorTitle,
                                color: color,
                                heroContainer: heroContainer,
                                heroTitle: heroTitle,
                                heroPop: heroPop,
                                heroDetails: heroDetails,
                                heroButtonRight: heroButtonRight,
                                title: title),
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

class _ContentErstellenView extends StatelessWidget {
  const _ContentErstellenView({
    Key key,
    @required this.neu,
    @required this.type,
    @required this.scrollController,
    this.title,
  }) : super(key: key);

  final bool neu;
  final dynamic type;
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
                                  ErstellenTextField(
                                    title: true,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ErstellenFaecherAuswahlView(),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ErstellenTextField(
                                    title: false,
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),

                                  //FachTestDrop(),
                                  // ErstellenDatumAuswahl(),
                                  ContainerWidget(
                                    child: ErstellenFuerButton(),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  !neu
                                      ? ContainerWidget(
                                          child: ErstellenDelete(type: type))
                                      : Wrap(),
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

class ErstellenDelete extends ViewModelBuilderWidget<ErstellenViewModel> {
  const ErstellenDelete({
    this.type,
    Key key,
  }) : super(key: key);

  final dynamic type;
  @override
  Widget builder(BuildContext context, ErstellenViewModel model, Widget child) {
    return GestureDetector(
      onTap: () {
        model.delete();
      },
      child: Container(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${type.typeName} löschen',
              style: Theme.of(context).textTheme.headline2,
            ),
            SizedBox(
              height: 30,
              child: Icon(
                Icons.delete_rounded,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  ErstellenViewModel viewModelBuilder(BuildContext context) =>
      ErstellenViewModel();
}

class ErstellenDatumAuswahl extends StatelessWidget {
  const ErstellenDatumAuswahl({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ErstellenViewModel>.nonReactive(
        builder: (context, model, child) => Container(
              child: Material(child: Container()),
            ),
        viewModelBuilder: () => locator<ErstellenViewModel>());
  }
}
