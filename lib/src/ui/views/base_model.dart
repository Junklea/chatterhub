import 'package:chatterhub/src/app/locator.dart';
import 'package:chatterhub/src/models/my_user.dart';
import 'package:chatterhub/src/services/authentication_service.dart';
import 'package:stacked/stacked.dart';

class BaseModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      getIt<AuthenticationService>();

  MyUser get currentUser => _authenticationService.currentUser;
}
