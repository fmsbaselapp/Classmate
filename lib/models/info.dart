class Info {
  final String titel;
  final String notiz;
  final String datum;
  final bool privat;
  final String fach;

  Info({this.titel, this.notiz, this.datum, this.privat, this.fach});

  factory Info.fromMap(Map data) {
    return Info(
      titel: data['titel'] ?? '',
      notiz: data['notiz'] ?? '',
      datum: data['datum'] ?? '',
      privat: data['privat'] ?? '',
      fach: data['fach'] ?? '',
    );
  }
}
