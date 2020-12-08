import 'package:Classmate/services/services.dart';
import 'package:Classmate/ui/shared/export.dart';
import 'package:Classmate/ui/views/viewmodels.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class ContentPanelView extends StatelessWidget {
  DateFormat dateFormat = DateFormat(
    "dd. MMM",
  );
  ContentPanelView({
    this.content,
    this.isAufgabe,
    this.isInfo,
    this.isTest,
    @required this.index,
    Key key,
  }) : super(key: key);

  final dynamic content;
  bool isAufgabe;
  bool isTest;
  bool isInfo;

  final int index;
  final GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    if (isAufgabe == null) {
      isAufgabe = false;
    }
    if (isTest == null) {
      isTest = false;
    }
    if (isInfo == null) {
      isInfo = false;
    }

    return ViewModelBuilder<ContentPanelViewModel>.reactive(
        disposeViewModel: false,
        //initialiseSpecialViewModelsOnce: true,
        builder: (context, model, child) {
          final type = model.type(isAufgabe, isTest, isInfo, content);
          final Color color = isAufgabe
              ? Color.fromRGBO(24, 118, 210, 1)
              : isTest
                  ? Color.fromRGBO(210, 48, 47, 1)
                  : Theme.of(context).highlightColor;
          final TextStyle colorTitle = isInfo
              ? Theme.of(context)
                  .textTheme
                  .headline2
                  .copyWith(color: Color.fromRGBO(252, 192, 45, 1))
              : Theme.of(context).textTheme.headline2;

          return GestureDetector(
            key: _key,
            onTap: () => model.goToDetailPage(
                context, index, _key, type, color, colorTitle),
            child: Column(
              children: [
                index == 0
                    ? SizedBox(
                        height: 15,
                      )
                    : Wrap(),
                Stack(
                  children: [
                    //DetailPageHero

                    PageStackHero(index: index, type: type),

                    //ContainerAufgabe
                    Positioned.fill(
                      child: Hero(
                        tag: 'Container' + index.toString() + type.docRef,
                        child: Container(
                          height:
                              65 * MediaQuery.textScaleFactorOf(context) * 0.85,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15)),
                          ),
                        ),
                      ),
                    ),

                    //PopButton
                    SizedBox(
                      height: 65 * MediaQuery.textScaleFactorOf(context) * 0.85,
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Hero(
                              tag: 'Pop' + index.toString() + type.docRef,
                              flightShuttleBuilder: (flightContext,
                                  animation,
                                  flightDirection,
                                  fromHeroContext,
                                  toHeroContext) {
                                final Hero toHero = fromHeroContext.widget;
                                return FadeTransition(
                                  opacity: animation.drive(
                                    Tween<double>(begin: 0.0, end: 1.0).chain(
                                      CurveTween(
                                        curve: Interval(0.6, 1.0,
                                            curve: Curves.easeInCirc),
                                      ),
                                    ),
                                  ),
                                  child: toHero,
                                );
                              },
                              child: Opacity(
                                  opacity: 0.0, child: ErstellenPopButton()))),
                    ),

                    //STACK
                    Positioned.fill(
                      child: Container(
                        padding: EdgeInsets.only(left: 15, right: 35),
                        child: Stack(
                          children: [
                            //Titel
                            Positioned.fill(
                              top: 9,
                              child: Hero(
                                tag: 'Title' + index.toString() + type.docRef,
                                child: Text(
                                  type.titel,
                                  style: colorTitle,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),

                            //Details
                            Positioned.fill(
                              child: Container(
                                padding: EdgeInsets.only(top: 29),
                                child: Hero(
                                  tag: 'Details' +
                                      index.toString() +
                                      type.docRef,
                                  flightShuttleBuilder: (flightContext,
                                      animation,
                                      flightDirection,
                                      fromHeroContext,
                                      toHeroContext) {
                                    final Hero toHero = toHeroContext.widget;
                                    return FadeTransition(
                                      opacity: animation.drive(
                                        Tween<double>(begin: 1.0, end: 0.0)
                                            .chain(
                                          CurveTween(
                                            curve: Interval(
                                              0.0,
                                              0.2,
                                            ),
                                          ),
                                        ),
                                      ),
                                      child: toHero.child,
                                    );
                                  },
                                  child: Opacity(
                                    opacity: 1.0,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        IconFach(
                                          farbe: type.fachFarbe,
                                          icon: type.fachIcon,
                                          small: true,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          type.fachName +
                                              ' | ' +
                                              dateFormat.format(type.datum),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    isAufgabe
                        ?
                        //AufgabeButton
                        Positioned.fill(
                            right: 15,
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Hero(
                                tag: 'ButtonRight' +
                                    index.toString() +
                                    type.docRef,
                                flightShuttleBuilder: (flightContext,
                                    animation,
                                    flightDirection,
                                    fromHeroContext,
                                    toHeroContext) {
                                  final Hero toHero = toHeroContext.widget;
                                  return FadeTransition(
                                    opacity: animation.drive(
                                      Tween<double>(begin: 1.0, end: 0.0).chain(
                                        CurveTween(
                                          curve: Interval(
                                            0.0,
                                            0.2,
                                          ),
                                        ),
                                      ),
                                    ),
                                    child: toHero.child,
                                  );
                                },
                                child: Opacity(
                                    opacity: 1.0, child: AufgabeButton()),
                              ),
                            ),
                          )
                        : Wrap()
                  ],
                ),
              ],
            ),
          );
        },
        viewModelBuilder: () => locator<ContentPanelViewModel>());
  }
}

class PageStackHero extends StatelessWidget {
  const PageStackHero({
    Key key,
    @required this.index,
    @required this.type,
  }) : super(key: key);

  final int index;
  final dynamic type;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'Page' + index.toString() + type.docRef,
      flightShuttleBuilder: (flightContext, animation, flightDirection,
          fromHeroContext, toHeroContext) {
        final Hero toHero = fromHeroContext.widget;
        return FadeTransition(
          opacity: animation.drive(
            Tween<double>(begin: 0.0, end: 1.0).chain(
              CurveTween(
                curve: Interval(
                  0.2,
                  0.5,
                ),
              ),
            ),
          ),
          child: toHero,
        );
      },
      child: Opacity(
        opacity: 0.0,
        child: Material(
          color: Colors.transparent,
          child: Container(
            height: 60,
            width: double.infinity,
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
