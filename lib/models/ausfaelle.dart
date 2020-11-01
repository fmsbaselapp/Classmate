class Ausfall {
  String klasse;
  String zeit;
  String grund;
  String raum;

  Ausfall({
    this.klasse,
    this.zeit,
    this.grund,
    this.raum,
  });

  factory Ausfall.fromList(List data) {
    data = data ?? [];
    return Ausfall(
      klasse: data[0] ?? '-',
      zeit: data[1] ?? '-',
      grund: data[2] ?? '-',
      raum: data[3] ?? '-',
    );
  }
}
