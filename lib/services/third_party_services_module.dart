import 'package:Classmate/services/services.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';

@module
abstract class ThirdPartyServicesModule {
  @lazySingleton
  NavigationService get navigationService;

  @lazySingleton
  AuthenticationService get authenticationService;

  @lazySingleton
  DialogService get dialogService;
}
