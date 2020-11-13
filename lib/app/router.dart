import 'package:Classmate/ui/views/calendar/calendar_view.dart';
import 'package:Classmate/ui/views/noten/noten_view.dart';
import 'package:Classmate/ui/views/views.dart';
import 'package:auto_route/auto_route_annotations.dart';

@MaterialAutoRouter(routes: [
  MaterialRoute(page: StartupView, initial: true),
  MaterialRoute(page: HomeView),
  MaterialRoute(page: CalendarView),
  MaterialRoute(page: NotenView),
  MaterialRoute(page: FaecherView),
  MaterialRoute(page: SettingsView),
  MaterialRoute(page: LoginView),
  MaterialRoute(page: SignUpView),
])
class $Router {}
