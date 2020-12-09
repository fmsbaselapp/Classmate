class Fach {
  final String name;
  final int farbe;
  final String icon;
  final String zeit;
  final String raum;
  final String docRef;
  final int teilnehmer;

  Fach({
    this.name,
    this.farbe,
    this.icon,
    this.zeit,
    this.raum,
    this.docRef,
    this.teilnehmer,
  });

  factory Fach.fromJSON(String id, Map<String, dynamic> data) {
    return Fach(
        name: data['name'] ?? '',
        zeit: data['zeit'] ?? '',
        icon: data['icon'] ?? '❔',
        farbe: data['farbe'] ?? 0,
        raum: data['raum'] ?? '',
        docRef: id,
        teilnehmer: data['teilnehmer'] ?? 000);
  }
}
