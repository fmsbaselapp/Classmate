class Test {
  final String titel;
  final String datum;
  final double gewichtung;
  final String notiz;
  final bool privat;
  final String fach;

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
      gewichtung: data['gewichtug'] ?? 1,
      notiz: data['notiz'] ?? '',
      privat: data['privat'] ?? true,
      fach: data['fach'] ?? '',
    );
  }
}
