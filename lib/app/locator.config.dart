// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';

import '../ui/views/aufgaben/aufgaben_viewmodel.dart';
import '../services/services.dart';
import '../ui/views/calendar/calendar_viewmodel.dart';
import '../ui/views/contentPanel/contentPanel_viewmodel.dart';
import '../ui/views/erstellen/erstellen_viewmodel.dart';
import '../ui/views/faecher/faecher_viewmodel.dart';
import '../ui/views/home/home_viewmodel.dart';
import '../ui/views/info/infos_viewmodel.dart';
import '../ui/views/noten/noten_viewmodel.dart';
import '../ui/views/settings/settings_viewmodel.dart';
import '../ui/views/startUp/startup_viewmodel.dart';
import '../ui/views/tests/tests_viewmodel.dart';
import '../services/third_party_services_module.dart';
import '../ui/views/uebersicht/uebersicht_viewmodel.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  final thirdPartyServicesModule = _$ThirdPartyServicesModule(get);
  gh.lazySingleton<AufgabenService<dynamic>>(
      () => thirdPartyServicesModule.aufgabenService);
  gh.lazySingleton<AuthenticationService>(
      () => thirdPartyServicesModule.authenticationService);
  gh.lazySingleton<BottomSheetService>(
      () => thirdPartyServicesModule.bottomSheetService);
  gh.lazySingleton<DialogService>(() => thirdPartyServicesModule.dialogService);
  gh.lazySingleton<FaecherService<dynamic>>(
      () => thirdPartyServicesModule.faecherService);
  gh.lazySingleton<InfosService<dynamic>>(
      () => thirdPartyServicesModule.infosService);
  gh.lazySingleton<NavigationService>(
      () => thirdPartyServicesModule.navigationService);
  gh.lazySingleton<TestsService<dynamic>>(
      () => thirdPartyServicesModule.testsService);
  gh.lazySingleton<UserData<dynamic>>(
      () => thirdPartyServicesModule.userService);

  // Eager singletons must be registered in the right order
  gh.singleton<AufgabenViewModel>(AufgabenViewModel());
  gh.singleton<CalendarViewModel>(CalendarViewModel());
  gh.singleton<ContentPanelViewModel>(ContentPanelViewModel());
  gh.singleton<ErstellenViewModel>(ErstellenViewModel());
  gh.singleton<FaecherViewModel>(FaecherViewModel());
  gh.singleton<HomeViewModel>(HomeViewModel());
  gh.singleton<InfosViewModel>(InfosViewModel());
  gh.singleton<NotenViewModel>(NotenViewModel());
  gh.singleton<SettingsViewModel>(SettingsViewModel());
  gh.singleton<StartupViewModel>(StartupViewModel());
  gh.singleton<TestsViewModel>(TestsViewModel());
  gh.singleton<UebersichtViewModel>(UebersichtViewModel());
  return get;
}

class _$ThirdPartyServicesModule extends ThirdPartyServicesModule {
  final GetIt _get;
  _$ThirdPartyServicesModule(this._get);
  @override
  AufgabenService<dynamic> get aufgabenService => AufgabenService();
  @override
  AuthenticationService get authenticationService => AuthenticationService();
  @override
  BottomSheetService get bottomSheetService => BottomSheetService();
  @override
  DialogService get dialogService => DialogService();
  @override
  FaecherService<dynamic> get faecherService => FaecherService();
  @override
  InfosService<dynamic> get infosService => InfosService();
  @override
  NavigationService get navigationService => NavigationService();
  @override
  TestsService<dynamic> get testsService => TestsService();
  @override
  UserData<dynamic> get userService => UserData(collection: _get<String>());
}
