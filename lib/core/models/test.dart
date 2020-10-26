import 'package:Classmate/core/models/models.dart';

class AlleTests {
  final List<Test> tests;

  AlleTests({this.tests});

  factory AlleTests.fromMap(Map data) {
    return AlleTests(
      tests: (data['alleTests'] as List ?? [])
          .map((v) => Test.fromMap(v))
          .toList(),
    );
  }
}

class Test {
  final String titel;
  final String datum;
  final double gewichtung;
  final String notiz;
  final bool privat;
  final Fach fach;

  Test(
      {this.titel,
      this.datum,
      this.gewichtung,
      this.notiz,
      this.privat,
      this.fach});

  factory Test.fromMap(Map data) {
    return Test(
        titel: data['titel'] ?? '',
        datum: data['datum'] ?? '',
        gewichtung: data['gewichtug'] ?? '',
        notiz: data['notiz'] ?? '',
        privat: data['privat'] ?? '',
        fach: (data['fach']) ?? '');
  }
}
