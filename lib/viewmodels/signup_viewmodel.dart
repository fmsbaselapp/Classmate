import 'package:Classmate/app/locator.dart';
import 'package:Classmate/app/router.gr.dart';
import 'package:Classmate/services/authentication_service.dart';
import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignUpViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future signUp({String email, String password, @required String type}) async {
    setBusy(true);

    //Email
    if (type == 'email') {
      var result = await _authenticationService.signUpWithEmail(
        email: email,
        password: password,
      );
      _check(result);

      //Apple
    } else if (type == 'apple') {
      var result = await _authenticationService.appleSignIn();
      _check(result);
    }

    setBusy(false);
  }

  void _check(result) async {
    if (result is bool) {
      if (result) {
        _navigationService.navigateTo(Routes.homeView);
      } else {
        await _dialogService.showDialog(
          title: 'Sign Up Failure',
          description: 'General sign up failure. Please try again later',
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Sign Up Failure',
        description: result ?? 'Error',
      );
    }
  }

  void logIn() => _navigationService.navigateTo(Routes.loginView);
  void logOut() async => await _authenticationService.logOut();
}
