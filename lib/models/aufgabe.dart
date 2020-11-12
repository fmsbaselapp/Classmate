import 'package:cloud_firestore/cloud_firestore.dart';

class Aufgabe {
  final String titel;
  final String fachName;
  final int fachFarbe;
  final String fachIcon;
  final String fachID;
  final DateTime datum;

  Aufgabe({
    this.titel,
    this.fachName,
    this.fachFarbe,
    this.fachIcon,
    this.fachID,
    this.datum,
  });

  factory Aufgabe.fromMap(Map data) {
    return Aufgabe(
        titel: data['titel'] ?? '',
        fachName: data['fachName'] ?? '',
        fachFarbe: data['fachFarbe'] ?? 0,
        fachIcon: data['fachIcon'] ?? '❔',
        fachID: data['fachID'] ?? '',
        datum: (data['datum'] as Timestamp ?? Timestamp(0, 0)).toDate());
  }
}
