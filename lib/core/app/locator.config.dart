// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';

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
  final thirdPartyServicesModule = _$ThirdPartyServicesModule();
  gh.lazySingleton<NavigationService>(
      () => thirdPartyServicesModule.navigationService);

  // Eager singletons must be registered in the right order
  gh.singleton<CalendarViewModel>(CalendarViewModel());
  gh.singleton<FaecherViewModel>(FaecherViewModel());
  gh.singleton<HomeViewModel>(HomeViewModel());
  gh.singleton<NotenViewModel>(NotenViewModel());
  gh.singleton<SettingsViewModel>(SettingsViewModel());
  gh.singleton<StaerupViewModel>(StaerupViewModel());
  gh.singleton<UebersichtViewModel>(UebersichtViewModel());
  return get;
}

class _$ThirdPartyServicesModule extends ThirdPartyServicesModule {
  @override
  NavigationService get navigationService => NavigationService();
}
