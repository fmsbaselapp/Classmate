import 'package:cloud_firestore/cloud_firestore.dart';

class Info {
  final String titel;
  final String notiz;
  final DateTime datum;
  final bool privat;
  final String fachName;
  final int fachFarbe;
  final String fachIcon;
  final String fachID;

  Info({
    this.titel,
    this.notiz,
    this.datum,
    this.privat,
    this.fachName,
    this.fachFarbe,
    this.fachIcon,
    this.fachID,
  });

  factory Info.fromMap(Map data) {
    return Info(
      titel: data['titel'] ?? '',
      notiz: data['notiz'] ?? '',
      datum: (data['datum'] as Timestamp ?? Timestamp(0, 0)).toDate(),
      privat: data['privat'] ?? true,
      fachName: data['fachName'] ?? '',
      fachFarbe: data['fachFarbe'] ?? 0,
      fachIcon: data['fachIcon'] ?? '❔',
      fachID: data['fachID'] ?? '',
    );
  }
}
