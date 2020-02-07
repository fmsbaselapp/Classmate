import 'package:Classmate/services/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationTagert {
  NotificationTagert(this.report);
  final Report report;
  final FirebaseMessaging _notification = FirebaseMessaging();

  update() {
    String _schule = report.schule;
    String _klasse = report.klasse;
    String _combined = _schule + '-' + _klasse;

    _notification.subscribeToTopic(_combined);
  }
}
