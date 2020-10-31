import 'package:Classmate/models/models.dart';

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
