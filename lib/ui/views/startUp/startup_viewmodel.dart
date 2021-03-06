import 'package:Classmate/app/locator.dart';
import 'package:Classmate/ui/views/home/home_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:stacked/stacked.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';

@singleton
class StartupViewModel extends FutureViewModel<dynamic> {
  final NavigationService _navigationService = locator<NavigationService>();
  // Initialize FlutterFire

  Future fbInitialize() async {
    setBusy(true);
    Firebase.initializeApp().then((value) async {
      setBusy(false);

      await _navigationService.replaceWithTransition(HomeView(),
          transition: 'fade',
          duration: Duration(milliseconds: 1500)); //TODO: Fade?
      print('Connected to Firebase');
    }).catchError((error) {
      print('error');
      onError(error);
      throw Exception('FB Error: $error');
    } //TODO: Error?});
        );
  }

  @override
  Future futureToRun() => fbInitialize();

  @override
  void onError(error) {
    //do Something
  }
}
