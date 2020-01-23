import 'services.dart';
//import 'package:firebase_analytics/firebase_analytics.dart';


/// Static global state. Immutable services that do not care about build context. 
class Global {
  // App Data
  static final String title = 'Classmate';

  // Services
 // static final FirebaseAnalytics analytics = FirebaseAnalytics();

    // Data Models
  static final Map models = {
    Topic: (data) => Topic.fromMap(data),
    Quiz: (data) => Quiz.fromMap(data),
    Report: (data) => Report.fromMap(data),
    Ausfall: (data) => Ausfall.fromList(data),

    Schule: (data) => Schule.fromMap(data),
  };

  // Firestore References for Writes
  //static final Collection<Topic> topicsRef = Collection<Topic>(path: 'topics');
  static final UserData<Report> reportRef = UserData<Report>(collection: 'Nutzer'); 
 static final Collection<Ausfall> ausfallRef = Collection<Ausfall>(path: 'Test');
  
}
