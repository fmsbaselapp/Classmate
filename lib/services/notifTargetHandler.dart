import 'package:Classmate/services/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationTagert {
  NotificationTagert(
      {@required this.report,
      this.userKlasse,
      this.userSchule,
      @required this.user});
  final Report report;
  final String userSchule;
  final String userKlasse;
  final FirebaseUser user;
  final FirebaseMessaging _notification = FirebaseMessaging();
  final Firestore _db = Firestore.instance;

  update() async {
    //SCHULE VORBEREITEN
    String _schuleLong = userSchule ?? report.schule;
    String _schuleAE =
        _schuleLong.replaceAll(new RegExp(r"\s+\b|\b\s|\s|\b"), "");
    String _schule = _schuleAE.replaceAll(RegExp('[äöü]'), '');
    String _klasse = userKlasse ?? report.klasse;
    String _target = _schule + '-' + _klasse;

    if (report.target != '') {
      //UNSUBSCRIBE FROM OLD CLASS TAREGT
      print('UNSUBSCRIBE FROM TARGET:' + report.target);
      await _notification.unsubscribeFromTopic(report.target).then(
            (value) =>
                print('---UNSUBSCRIBED from Topic ' + report.target + '---'),
          );

      //SUBSCRIBE TO NEW CLASS TAREGT
      DocumentReference reportRef = _db.collection('Nutzer').document(user.uid);
      await reportRef.setData({'Target': _target.toString()}, merge: true).then(
          (value) async {
        await _notification.subscribeToTopic(_target).then(
            (value) => print('---SUBSCRIBED to Topic ' + _target + '---'));
      });
    } else {
      //bei erstem mal
      DocumentReference reportRef = _db.collection('Nutzer').document(user.uid);
      return await reportRef
          .setData({'Target': _target.toString()}, merge: true).then(
        (value) async => await _notification.subscribeToTopic(_target),
      );
    }
  }

  unsubscribe() async {
    //UNSUBSCRIBE FROM OLD CLASS TAREGT
    print('UNSUBSCRIBE FROM TARGET:' + report.target);
    await _notification.unsubscribeFromTopic(report.target).then(
          (value) =>
              print('---UNSUBSCRIBED from Topic ' + report.target + '---'),
        );

    //SET NACHRICHTEN AUS

    DocumentReference reportRef = _db.collection('Nutzer').document(user.uid);
    await reportRef.setData({'Target': 'NachrichtenAus'}, merge: true).then(
        (value) async {
      await _notification.subscribeToTopic('NachrichtenAus').then((value) =>
          print('---SUBSCRIBED to Topic ' + 'NachrichtenAus' + '---'));
    });
  }
}

class NotifStateNotifier with ChangeNotifier {
  bool _notifData;

  NotifStateNotifier(this._notifData);

  getNotif() => _notifData;

  setNotif(bool notifData) async {
    _notifData = notifData;
    notifyListeners();
  }
}

void onNotifChanged(bool value, NotifStateNotifier notifStateNotifier,
    FirebaseUser user, Report report) async {
  if (value) {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('notifState', value);
    notifStateNotifier.setNotif(value);
    //Subscribe to Topic
    NotificationTagert(user: user, report: report).update();
  } else {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('notifState', value);
    notifStateNotifier.setNotif(value);
    //Unsubscribe from Topic
    NotificationTagert(user: user, report: report).unsubscribe();
  }
}

/*

 try {
      // await _notification.deleteInstanceID().whenComplete(
      // () async {

      await _notification.subscribeToTopic(_combined);

      //   },
       ).catchError(
          (onError) {
            Exception(onError);
          },
        );

      print('==============> TARGET: ' + _combined);
    } catch (e) {
      Exception(e);
    }
*/

/*
    await SharedPreferences.getInstance().then(
      (prefs) {
        final myTarget = prefs.getString('Target_KlassSchool') ?? [];
        try {
          if (myTarget != null) {
            _notification.unsubscribeFromTopic(myTarget);
          }

          _notification.subscribeToTopic(_combined);
          prefs.setString('Target_KlassSchool', _combined);
          print('==============> TARGET: ' + _combined);
        } catch (e) {
          Exception(e);
        }
      },
    );
  } */
