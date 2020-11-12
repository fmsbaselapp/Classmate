import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'locator.config.dart';

final locator = GetIt.instance;

@injectableInit
void setupLocator() => $initGetIt(locator);

//  flutter pub run build_runner build
//  flutter pub run build_runner build --delete-conflicting-outputs
/*

*/
