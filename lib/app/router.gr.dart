// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../ui/views/calendar/calendar_view.dart';
import '../ui/views/views.dart';

class Routes {
  static const String startupView = '/';
  static const String homeView = '/home-view';
  static const String calendarView = '/calendar-view';
  static const String notenView = '/noten-view';
  static const String faecherView = '/faecher-view';
  static const String settingsView = '/settings-view';
  static const String loginView = '/login-view';
  static const String signUpView = '/sign-up-view';
  static const all = <String>{
    startupView,
    homeView,
    calendarView,
    notenView,
    faecherView,
    settingsView,
    loginView,
    signUpView,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.startupView, page: StartupView),
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.calendarView, page: CalendarView),
    RouteDef(Routes.notenView, page: NotenView),
    RouteDef(Routes.faecherView, page: FaecherView),
    RouteDef(Routes.settingsView, page: SettingsView),
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.signUpView, page: SignUpView),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    StartupView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const StartupView(),
        settings: data,
      );
    },
    HomeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const HomeView(),
        settings: data,
      );
    },
    CalendarView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const CalendarView(),
        settings: data,
      );
    },
    NotenView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const NotenView(),
        settings: data,
      );
    },
    FaecherView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const FaecherView(),
        settings: data,
      );
    },
    SettingsView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const SettingsView(),
        settings: data,
      );
    },
    LoginView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LoginView(),
        settings: data,
      );
    },
    SignUpView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SignUpView(),
        settings: data,
      );
    },
  };
}
