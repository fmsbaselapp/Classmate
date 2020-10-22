//import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:Classmate/Services/services.dart';
import 'package:flutter/material.dart';

/// Static global state. Immutable services that do not care about build context.
class Global {
  // App Data
  static final String title = 'Classmate';

  // Services
  // static final FirebaseAnalytics analytics = FirebaseAnalytics();

  // Data Models final
  /*
  static final Map models = {
    Fach: (data) => Fach.fromMap(data),
    Info: (data) => Info.fromMap(data),
    Aufgabe: (data) => Aufgabe.fromMap(data),
    Test: (data) => Test.fromMap(data),
  };
*/
// Data Models fake

  static final Map models = {
    AlleFaecher: (data) => AlleFaecher.fromMap(data),
    AlleInfos: (data) => AlleInfos.fromMap(data),
    AlleAufgaben: (data) => AlleAufgaben.fromMap(data),
    AlleTests: (data) => AlleTests.fromMap(data),
    Fach: (data) => Fach.fromMap({
          'name': 'Biologie',
          'farbe': Color.fromRGBO(170, 255, 180, 1),
          'icon': '🌱',
          'zeit': '12:30-13:40',
          'raum': '22B',
          'teilnehmer': 12,
        }),
    Info: (data) => Info.fromMap({
          'titel': 'Stunde fällt aus',
          'notiz': 'Die nächste Stunde fällt aus',
          'datum': 'Montag, 2, Febuar',
          'privat': true,
          'fach': 'Biologie'
        }),
    Aufgabe: (data) => Aufgabe.fromMap({
          'titel': 'Deutsch lösen',
          'datum': 'Montag, 8, Febuar',
          'fach': 'Geographie',
          'notiz': 'Keine Notizen',
          'privat': false,
        }),
    Test: (data) => Test.fromMap({
          'titel': 'Deutsch lösen',
          'datum': 'Montag, 8, Febuar',
          'fach': 'Geographie',
          'notiz': 'Keine Notizen',
          'gewichtung': 1.3,
          'privat': false,
        }),
  };

  // Firestore References for Writes
  //static final Collection<Topic> topicsRef = Collection<Topic>(path: 'topics');

  /*
  static final UserData<Report> reportRef =
      UserData<Report>(collection: 'Nutzer');
  static final Collection<Ausfall> ausfallRef =
      Collection<Ausfall>(path: 'Test');
  */
}
