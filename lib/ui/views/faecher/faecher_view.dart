import 'package:Classmate/app/locator.dart';
import 'package:Classmate/models/models.dart';
import 'package:Classmate/ui/custom_icons_icons.dart';
import 'package:Classmate/ui/shared/export.dart';
import 'package:Classmate/ui/views/viewmodels.dart';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class FaecherView extends StatelessWidget {
  const FaecherView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FaecherViewModel>.reactive(

        // 1 dispose viewmodel
        disposeViewModel: false,
        // 3. set initialiseSpecialViewModelsOnce to true to indicate only initialising once
        initialiseSpecialViewModelsOnce: true,
        builder: (context, model, child) => Scaffold(
              body: SafeArea(
                child: CustomScrollView(
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  key: PageStorageKey('Faecher_Column_Key'),
                  slivers: [
                    CustomAppBar(
                      title: 'Fächer',
                      onPressed: () {},
                    ),
                    SliverPadding(
                      padding: EdgeInsets.only(left: 15, right: 15, top: 20),
                      sliver: model.hasData
                          ? SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  Fach fach = model.faecher[index];
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 15),
                                    child: FachPanel(fach: fach, index: index),
                                  );
                                },
                                childCount: model.faecher.length,
                              ),
                            )
                          : SliverToBoxAdapter(
                              child: Center(
                                //TODO: Loading
                                child: Container(
                                  height: 1000,
                                  color: Colors.blue,
                                  child: Text('Keine Daten'),
                                ),
                              ),
                            ),
                    )
                  ],
                ),
              ),
            ),
        viewModelBuilder: () => locator<FaecherViewModel>());
  }
}

class FachPanel extends StatelessWidget {
  FachPanel({
    Key key,
    @required this.fach,
    @required this.index,
  }) : super(key: key);

  final Fach fach;
  final int index;
  GlobalKey _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FaecherViewModel>.reactive(

        // 1 dispose viewmodel
        disposeViewModel: false,
        // 3. set initialiseSpecialViewModelsOnce to true to indicate only initialising once
        initialiseSpecialViewModelsOnce: true,
        builder: (context, model, child) => GestureDetector(
              key: _key,
              onTap: () {
                model.navigateToDetailPage(
                  /*   
                context, index, _key, type, color, colorTitle), */

                  fach,
                  index,
                  context,
                  _key,
                );
              },
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

                      PageStackHeroFaecher(index: index, fach: fach),

                      //ContainerAufgabe
                      Positioned.fill(
                        child: Hero(
                          tag: 'Container' + index.toString() + fach.docRef,
                          child: Container(
                            height: 80 *
                                MediaQuery.textScaleFactorOf(context) *
                                0.85,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Theme.of(context).accentColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                            ),
                          ),
                        ),
                      ),

                      //PopButton
                      SizedBox(
                        height:
                            80 * MediaQuery.textScaleFactorOf(context) * 0.85,
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Hero(
                                tag: 'Pop' + index.toString() + fach.docRef,
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
                                    opacity: 0.0,
                                    child: /* ErstellenPopButton() */ Container(
                                      height: 30,
                                      color: Colors.green,
                                    )))),
                      ),

                      //STACK
                      Positioned.fill(
                        child: Container(
                          padding: EdgeInsets.only(left: 15, right: 30),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                top: 5,
                                bottom: 4,
                                child: Hero(
                                  tag: 'Title' + index.toString() + fach.docRef,

                                  //Details
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: 10),
                                        child: IconFach(
                                          farbe: fach.farbe,
                                          icon: fach.icon,
                                          size: 40,
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            fach.name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline2,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                fach.zeit + ' | ' + fach.raum,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned.fill(
                        right: 15,
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: RoundButton(
                              icon: CustomIcons.add,
                              iconSize: 15,
                              onPressed: () {}),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
        viewModelBuilder: () => locator<FaecherViewModel>());
  }
}

class PageStackHeroFaecher extends StatelessWidget {
  const PageStackHeroFaecher({
    Key key,
    @required this.index,
    @required this.fach,
  }) : super(key: key);

  final int index;
  final Fach fach;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'Page' + index.toString() + fach.docRef,
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
