class AlleFaecher {
  final List<Fach> faecher;

  AlleFaecher({this.faecher});

  factory AlleFaecher.fromMap(Map data) {
    return AlleFaecher(
      faecher:
          (data['Faecher'] as List ?? []).map((v) => Fach.fromMap(v)).toList(),
    );
  }
}

class Fach {
  final String name;
  final int farbe;
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
        zeit: data['zeit'] ?? '',
        icon: data['icon'] ?? '❔',
        farbe: data['farbe'] ?? 0,
        raum: data['raum'] ?? '',
        teilnehmer: data['teilnehmer'] ?? 000);
  }
}
