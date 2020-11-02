class AlleAufgaben {
  final List<Aufgabe> aufgaben;

  AlleAufgaben({this.aufgaben});

  factory AlleAufgaben.fromMap(Map data) {
    return AlleAufgaben(
      aufgaben: (data['Aufgaben'] as List ?? [])
          .map((v) => Aufgabe.fromMap(v))
          .toList(),
    );
  }
}

class Aufgabe {
  final String titel;
  final String fach;
  final String datum;

  Aufgabe({
    this.titel,
    this.fach,
    this.datum,
  });

  factory Aufgabe.fromMap(Map data) {
    return Aufgabe(
      titel: data['titel'] ?? '',
      fach: data['fach'] ?? '',
      datum: data['datum'] ?? '',
    );
  }
}
