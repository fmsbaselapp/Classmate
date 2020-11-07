import 'package:Classmate/services/services.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';

@module
abstract class ThirdPartyServicesModule {
  @lazySingleton
  NavigationService get navigationService;

  @lazySingleton
  DialogService get dialogService;

  @lazySingleton
  AuthenticationService get authenticationService;

  @lazySingleton
  FaecherService get faecherService;

  @lazySingleton
  AufgabenService get aufgabenService;

  @lazySingleton
  InfosService get infosService;

  @lazySingleton
  TestsService get testsService;

  @lazySingleton
  UserData get userService;
}

//     flutter pub run build_runner build --delete-conflicting-outputs
