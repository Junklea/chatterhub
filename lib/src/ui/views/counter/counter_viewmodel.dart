import 'package:chatterhub/src/app/locator.dart';
import 'package:chatterhub/src/services/authentication_service.dart';
import 'package:stacked/stacked.dart';

class CounterViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      getIt<AuthenticationService>();

  String _title = 'Home View';
  String get title => '$_title $counter';

  int _counter = 0;
  int get counter => _counter;

  void updateCounter() {
    _authenticationService.signOut();
    // _counter++;
    // notifyListeners();
  }
}
