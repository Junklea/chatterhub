import 'package:chatterhub/src/app/locator.dart';
import 'package:chatterhub/src/app/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final NavigationService _navigationService = getIt<NavigationService>();

  Future navigateToHome() async {
    await _navigationService.navigateTo(Routes.counterView);
  }
}
