import 'dart:async';
import 'dart:io';

import 'package:Classmate/screens/screens.dart';
import 'package:Classmate/services/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';



class MessageHandler extends StatefulWidget {
  MessageHandler({
    Key key,
    @required TabController controller,
    @required this.report,
  })  : _controller = controller,
        super(key: key);
  final TabController _controller;
  final Report report;
  @override
  _MessageHandlerState createState() => _MessageHandlerState();
}

class _MessageHandlerState extends State<MessageHandler> {
  final Firestore _db = Firestore.instance;
  final FirebaseMessaging _notification = FirebaseMessaging();
  StreamSubscription iosSubscription;
  @override
  void initState() {
    super.initState();

    if (Platform.isIOS) {
      iosSubscription = _notification.onIosSettingsRegistered.listen((data) {
        _safeDeviceToken();
      });
      _notification.requestNotificationPermissions(
        IosNotificationSettings(),
      );
    } else {
      _safeDeviceToken();
    }

   // _notification.subscribeToTopic('3C');

    _notification.configure(onMessage: (Map<String, dynamic> message) async {
      print("onMessage: $message");
      final snackbar = SnackBar(
        content: Text(
          message['notification']['title'],
        ),
        action: SnackBarAction(
          label: 'Go',
          onPressed: () => null,
        ),
      );

      Scaffold.of(context).showSnackBar(snackbar);
    }, onResume: (Map<String, dynamic> message) async {
      print("onResume: $message");
    }, onLaunch: (Map<String, dynamic> message) async {
      print("onLaunch: $message");
    });
  }

  @override
  void dispose() {
    iosSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: HomeBody(controller: widget._controller, report: widget.report),
    );
  }

  _safeDeviceToken() async {
    FirebaseUser user = await AuthService().getUser;
    String fmcToken = await _notification.getToken();

    if (fmcToken != null) {
      DocumentReference tokenRef = _db.collection('Nutzer').document(user.uid);
      print('habe Token');
      await tokenRef.updateData(
        {
          'fmcToken': {
            'token': fmcToken,
            'erstelltAm': FieldValue.serverTimestamp(),
            'platform': Platform.operatingSystem,
          }
        },
      );
    }
  }
}