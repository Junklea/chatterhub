import 'package:chatterhub/src/app/locator.dart';
import 'package:chatterhub/src/app/router.gr.dart';
import 'package:chatterhub/src/services/authentication_service.dart';
import 'package:flutter/foundation.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignUpViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      getIt<AuthenticationService>();
  final DialogService _dialogService = getIt<DialogService>();
  final NavigationService _navigationService = getIt<NavigationService>();

  Future signUp({
    @required String email,
    @required String password,
    @required String fullName,
  }) async {
    setBusy(true);

    var result = await _authenticationService.signUpWithEmail(
      email: email,
      password: password,
      fullName: fullName,
      role: 'User',
    );

    setBusy(false);

    if (result is bool) {
      if (result) {
        print("lol");
        _navigationService.navigateTo(Routes.startupView);
      } else {
        await _dialogService.showDialog(
          title: 'Sign Up Failure',
          description: 'General sign up failure. Please try again later',
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Sign Up Failure',
        description: result,
      );
    }
  }

  void navigateToLogin() {
    _navigationService.navigateTo(Routes.loginView);
  }
}
