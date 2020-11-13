import 'package:Classmate/app/locator.dart';
import 'package:Classmate/ui/views/home/home_viewmodel.dart';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.nonReactive(
        // 1 dispose viewmodel
        disposeViewModel: false,
        // 3. set initialiseSpecialViewModelsOnce to true to indicate only initialising once
        initialiseSpecialViewModelsOnce: true,
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: Text('Einstellungen'),
              ),
              body: SafeArea(
                child: Padding(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        SettingsButton(test: 'Aufgaben und Tests'),
                        SettingsButton(test: 'Ferienmodus'),
                        SettingsButton(test: 'Klasse'),
                        SettingsButton(test: 'Schule'),
                        SettingsButton(test: 'Mitteilungen'),
                        SettingsButton(test: 'Aussehen'),
                        SettingsButton(test: 'Übersicht'),
                        SettingsButton(test: 'Stundenplan'),
                        SettingsButton(test: 'Noten'),
                        SettingsButton(test: 'Fächer'),
                        SettingsButton(test: 'Support'),
                        SettingsButton(test: 'Kontakt'),
                        SettingsButton(test: 'Abmelden'),
                        SettingsButton(test: 'Nutzungsbedingungen'),
                        SettingsButton(test: 'Datenschutzerklärung'),
                      ],
                    )),
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
