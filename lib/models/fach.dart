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
