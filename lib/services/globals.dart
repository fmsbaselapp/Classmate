//import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:Classmate/models/models.dart';
import 'package:Classmate/services/services.dart';
import 'package:Classmate/services/user_service.dart';
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
    Fach: (data) => Fach.fromMap({}),
    Info: (data) => Info.fromMap({}),
    Aufgabe: (data) => Aufgabe.fromMap({}),
    Test: (data) => Test.fromMap({}),
  };

  // Firestore References for Writes
  //static final Collection<Topic> topicsRef = Collection<Topic>(path: 'topics');

  static final UserData<Report> reportRef =
      UserData<Report>(collection: 'Nutzer');
  static final Collection<Ausfall> ausfallRef =
      Collection<Ausfall>(path: 'Ausfall');

  //ect...
}
