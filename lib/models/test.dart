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
  final String typeName;
  final String docRef;

  Test(
      {this.titel,
      this.datum,
      this.gewichtung,
      this.notiz,
      this.privat,
      this.fachName,
      this.fachFarbe,
      this.fachIcon,
      this.fachID,
      this.typeName,
      this.docRef});

  factory Test.fromJSON(String id, Map<String, dynamic> data) {
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
      docRef: id,
      typeName: 'Test',
    );
  }
}
