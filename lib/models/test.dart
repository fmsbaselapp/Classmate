import 'package:cloud_firestore/cloud_firestore.dart';

class Test {
  final String titel;
  final DateTime datum;
  final double gewichtung;
  final String notiz;
  final bool privat;

  final String fachName;
  final int fachFarbe;
  final String fachIcon;
  final String fachID;

  Test({
    this.titel,
    this.datum,
    this.gewichtung,
    this.notiz,
    this.privat,
    this.fachName,
    this.fachFarbe,
    this.fachIcon,
    this.fachID,
  });

  factory Test.fromMap(Map data) {
    return Test(
      titel: data['titel'] ?? '',
      datum: (data['datum'] as Timestamp ?? Timestamp(0, 0)).toDate(),
      gewichtung: data['gewichtug'] ?? 1,
      notiz: data['notiz'] ?? '',
      privat: data['privat'] ?? true,
      fachName: data['fachName'] ?? '',
      fachFarbe: data['fachFarbe'] ?? 0,
      fachIcon: data['fachIcon'] ?? '❔',
      fachID: data['fachID'] ?? '',
    );
  }
}
