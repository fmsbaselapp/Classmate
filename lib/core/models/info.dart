import 'package:Classmate/core/models/models.dart';

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
