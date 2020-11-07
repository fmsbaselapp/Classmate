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
