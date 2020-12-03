import 'package:Classmate/services/services.dart';
import 'package:Classmate/ui/shared/export.dart';
import 'package:Classmate/ui/views/erstellen/erstellen_viewmodel.dart';

import 'package:Classmate/ui/views/viewmodels.dart';
import 'package:flutter/material.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import 'package:stacked/stacked.dart';

class ErstellenView extends StatelessWidget {
  ErstellenView({
    @required this.colorTitle,
    @required this.color,
    @required this.type,
    @required this.heroContainer,
    @required this.heroTitle,
    @required this.heroPage,
    @required this.heroPop,
    @required this.heroDetails,
    @required this.heroButtonRight,
    Key key,
  }) : super(key: key);

  final dynamic type;

  final TextStyle colorTitle;
  final Color color;
  final String heroContainer;
  final String heroPage;
  final String heroTitle;
  final String heroPop;
  final String heroDetails;
  final String heroButtonRight;
  SheetController controller = SheetController();

  @override
  Widget build(BuildContext context) {
    print('Build: ErstellenView');
    return ViewModelBuilder<ErstellenViewModel>.nonReactive(
        disposeViewModel: false,
        //initialiseSpecialViewModelsOnce: true,
        builder: (context, model, child) {
          model.initialize();
          model.faecherAuswahlShow();

          return SlidingSheet(
            elevation: 10,
            cornerRadius: 15,
            duration: const Duration(milliseconds: 550),
            controller: controller,
            color: model.transparent
                ? Colors.transparent
                : Theme.of(context).accentColor,
            shadowColor: Colors.transparent,
            maxWidth: 500,
            cornerRadiusOnFullscreen: 0.0,
            closeOnBackdropTap: true,
            closeOnBackButtonPressed: true,
            isBackdropInteractable: true,
            addTopViewPaddingOnFullscreen: true,
            snapSpec: SnapSpec(
              snap: true,
              positioning: SnapPositioning.relativeToAvailableSpace,
              initialSnap: SnapSpec.expanded,
              snappings: const [SnapSpec.expanded, 0.5],
              onSnap: (state, snap) {
                print('Snapped to $snap');
              },
            ),
            /* parallaxSpec: const ParallaxSpec(
              enabled: true,
              amount: 0.35,
              endExtent: 0.6,
            ), */
            liftOnScrollHeaderElevation: 12.0,
            headerBuilder: (context, state) => ErstellenAppBar(
                type: type,
                colorTitle: colorTitle,
                color: color,
                heroContainer: heroContainer,
                heroTitle: heroTitle,
                heroPop: heroPop,
                heroDetails: heroDetails,
                heroButtonRight: heroButtonRight),
            builder: (context, state) => Hero(
              tag: heroPage,
              flightShuttleBuilder: (flightContext, animation, flightDirection,
                  fromHeroContext, toHeroContext) {
                final Hero toHero = toHeroContext.widget;
                return FadeTransition(
                  opacity: animation.drive(
                    Tween<double>(begin: 0.0, end: 1.0).chain(
                      CurveTween(
                        curve: Interval(
                          0.0,
                          0.2,
                        ),
                      ),
                    ),
                  ),
                  child: toHero,
                );
              },
              child: Opacity(
                opacity: 1.0,
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    decoration: new BoxDecoration(
                      /* borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(20.0),
                          topRight: const Radius.circular(20.0),
                        ), */
                      color: Theme.of(context).accentColor,
                    ),
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onPanDown: (_) {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 15, right: 15, top: 0, bottom: 30),
                        child: ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          //controller: snappingSheetController,
                          children: [
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
                            type != null
                                ? ContainerWidget(
                                    child: ErstellenDelete(type: type),
                                  )
                                : Wrap(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
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
        model.delete(type);
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

/* class ErstellenDatumAuswahl extends StatelessWidget {
  const ErstellenDatumAuswahl({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ErstellenViewModel>.nonReactive(
        builder: (context, model, child) => Container(),
        viewModelBuilder: () => locator<ErstellenViewModel>());
  }
} */
