import 'package:flutter/material.dart';

class AlleFaecher {
  final List<Fach> faecher;

  AlleFaecher({this.faecher});

  factory AlleFaecher.fromMap(Map data) {
    return AlleFaecher(
      faecher: (data['allefaecher'] as List ?? [])
          .map((v) => Fach.fromMap(v))
          .toList(),
    );
  }
}

class Fach {
  final String name;
  final Color farbe;
  final String icon;
  final String zeit;
  final String raum;
  final int teilnehmer;

  Fach(
      {this.name,
      this.farbe,
      this.icon,
      this.zeit,
      this.raum,
      this.teilnehmer});

  factory Fach.fromMap(Map data) {
    return Fach(
        name: data['name'] ?? '',
        farbe: data['farbe'] ?? '',
        icon: data['icon'] ?? '',
        zeit: data['zeit'] ?? '',
        raum: (data['raum']) ?? '',
        teilnehmer: (data['teilnehmer']) ?? '');
  }
}

class AlleInfos {
  final List<Info> infos;

  AlleInfos({this.infos});

  factory AlleInfos.fromMap(Map data) {
    return AlleInfos(
      infos: (data['alleinfos'] as List ?? [])
          .map((v) => Info.fromMap(v))
          .toList(),
    );
  }
}

class Info {
  final String titel;
  final String notiz;
  final String datum;
  final bool privat;
  final Fach fach;

  Info({this.titel, this.notiz, this.datum, this.privat, this.fach});

  factory Info.fromMap(Map data) {
    return Info(
        titel: data['titel'] ?? '',
        notiz: data['notiz'] ?? '',
        datum: data['datum'] ?? '',
        privat: data['privat'] ?? '',
        fach: (data['fach']) ?? '');
  }
}

class AlleAufgaben {
  final List<Aufgabe> aufgaben;

  AlleAufgaben({this.aufgaben});

  factory AlleAufgaben.fromMap(Map data) {
    return AlleAufgaben(
      aufgaben: (data['alleAufgaben'] as List ?? [])
          .map((v) => Aufgabe.fromMap(v))
          .toList(),
    );
  }
}

class Aufgabe {
  final String titel;
  final String datum;
  final String notiz;
  final bool fertig;
  final bool privat;
  final Fach fach;

  Aufgabe(
      {this.titel,
      this.datum,
      this.notiz,
      this.fertig,
      this.privat,
      this.fach});

  factory Aufgabe.fromMap(Map data) {
    return Aufgabe(
        titel: data['titel'] ?? '',
        datum: data['datum'] ?? '',
        notiz: data['notiz'] ?? '',
        fertig: data['fertig'] ?? '',
        privat: data['privat'] ?? '',
        fach: (data['fach']) ?? '');
  }
}

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
