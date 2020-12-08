import 'package:Classmate/app/locator.dart';
import 'package:Classmate/ui/shared/export.dart';
import 'package:Classmate/ui/views/home/home_viewmodel.dart';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key key}) : super(key: key);

  static List<String> titles = [
    'Aufgaben und Tests',
    'Ferienmodus',
    'Klasse',
    'Schule',
    'Mitteilungen',
    'Aussehen',
    'Übersicht',
    'Stundenplan',
    'Noten',
    'Fächer',
    'Support',
    'Kontakt',
    'Abmelden',
    'Nutzungsbedingungen',
    'Datenschutzerklärung',
  ];

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.nonReactive(
        // 1 dispose viewmodel
        disposeViewModel: false,
        // 3. set initialiseSpecialViewModelsOnce to true to indicate only initialising once
        initialiseSpecialViewModelsOnce: true,
        builder: (context, model, child) => Scaffold(
              body: SafeArea(
                child: CustomScrollView(
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  key: PageStorageKey('Settings_Column_Key'),
                  slivers: [
                    CustomAppBar(
                      title: 'Einstellungen',
                      onPressed: () {},
                    ),
                    SliverPadding(
                      padding: EdgeInsets.only(left: 15, right: 15, top: 20),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: SettingsButton(test: titles[index]));
                          },
                          childCount: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        viewModelBuilder: () => locator<HomeViewModel>());
  }
}

class SettingsButton extends StatelessWidget {
  const SettingsButton({
    Key key,
    @required this.test,
  }) : super(key: key);

  final String test;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 15),
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(0.00, 5.00),
            color: Color(0xff000000).withOpacity(0.10),
            blurRadius: 20,
          ),
        ],
        borderRadius: BorderRadius.circular(100),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          test,
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
    );
  }
}
