// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';

import '../services/services.dart';
import '../viewmodels/calendar_viewmodel.dart';
import '../viewmodels/faecher_viewmodel.dart';
import '../viewmodels/home_viewmodel.dart';
import '../viewmodels/noten_viewmodel.dart';
import '../viewmodels/settings_viewmodel.dart';
import '../viewmodels/startup_viewmodel.dart';
import '../services/third_party_services_module.dart';
import '../viewmodels/uebersicht_viewmodel.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  final thirdPartyServicesModule = _$ThirdPartyServicesModule(get);
  gh.lazySingleton<AuthenticationService>(
      () => thirdPartyServicesModule.authenticationService);
  gh.lazySingleton<DialogService>(() => thirdPartyServicesModule.dialogService);
  gh.lazySingleton<FaecherService<dynamic>>(
      () => thirdPartyServicesModule.faecherService);
  gh.lazySingleton<NavigationService>(
      () => thirdPartyServicesModule.navigationService);
  gh.lazySingleton<UserData<dynamic>>(
      () => thirdPartyServicesModule.userService);

  // Eager singletons must be registered in the right order
  gh.singleton<CalendarViewModel>(CalendarViewModel());
  gh.singleton<FaecherViewModel>(FaecherViewModel());
  gh.singleton<HomeViewModel>(HomeViewModel());
  gh.singleton<NotenViewModel>(NotenViewModel());
  gh.singleton<SettingsViewModel>(SettingsViewModel());
  gh.singleton<StartupViewModel>(StartupViewModel());
  gh.singleton<UebersichtViewModel>(UebersichtViewModel());
  return get;
}

class _$ThirdPartyServicesModule extends ThirdPartyServicesModule {
  final GetIt _get;
  _$ThirdPartyServicesModule(this._get);
  @override
  AuthenticationService get authenticationService => AuthenticationService();
  @override
  DialogService get dialogService => DialogService();
  @override
  FaecherService<dynamic> get faecherService => FaecherService();
  @override
  NavigationService get navigationService => NavigationService();
  @override
  UserData<dynamic> get userService => UserData(collection: _get<String>());
}
