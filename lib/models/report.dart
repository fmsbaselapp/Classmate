import 'package:cloud_firestore/cloud_firestore.dart';

class Report {
  String email;
  String vorname;
  String nachname;
  String schule;
  String klasse;
  String target;
  String uid;
  Timestamp lastActivity;

  Report(
      {this.uid,
      this.target,
      this.klasse,
      this.schule,
      this.email,
      this.lastActivity,
      this.nachname,
      this.vorname});

  factory Report.fromMap(Map data) {
    return Report(
        email: data['Email'] ?? ' ',
        vorname: data['Vorname'] ?? ' ',
        nachname: data['Nachname'] ?? ' ',
        schule: data['Schule'] ?? 'keine Schule',
        klasse: data['Klasse'] ?? 'keine Klasse',
        uid: data['uid'] ?? ' ',
        target: data['Target'] ?? '',
        lastActivity: data['lastActivity']);
  }
}
