import 'package:cloud_firestore/cloud_firestore.dart';

class Aufgabe {
  final String titel;
  final String fachName;
  final int fachFarbe;
  final String fachIcon;
  final String fachID;
  final DateTime datum;
  final String typeName;
  final String docRef;

  Aufgabe(
      {this.titel,
      this.fachName,
      this.fachFarbe,
      this.fachIcon,
      this.fachID,
      this.datum,
      this.typeName,
      this.docRef});

  factory Aufgabe.fromJSON(String id, Map<String, dynamic> data) {
    return Aufgabe(
        titel: data['titel'] ?? '',
        fachName: data['fachName'] ?? '',
        fachFarbe: data['fachFarbe'] ?? 0,
        fachIcon: data['fachIcon'] ?? '❔',
        fachID: data['fachID'] ?? '',
        typeName: 'Aufgabe',
        docRef: id,
        datum: (data['datum'] as Timestamp ?? Timestamp(0, 0)).toDate());
  }
}
