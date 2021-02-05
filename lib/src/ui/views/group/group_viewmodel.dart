import 'package:chatterhub/src/app/locator.dart';
import 'package:chatterhub/src/models/my_message.dart';
import 'package:chatterhub/src/services/authentication_service.dart';
import 'package:chatterhub/src/services/firestore_service.dart';
import 'package:stacked/stacked.dart';

class GroupViewModel extends BaseViewModel {
  final FirestoreService _firestoreService = getIt<FirestoreService>();
  final AuthenticationService _authenticationService =
      getIt<AuthenticationService>();

  List<MyMessage> _messages;
  List<MyMessage> get messages => _messages;

  void listenToMessages(String id) {
    setBusy(true);
    _firestoreService.getMessagesByGroupDocId(id).listen((chatRoomsData) {
      // print(id);
      List<MyMessage> updatedMessages = chatRoomsData;
      if (updatedMessages != null && updatedMessages.length > 0) {
        // print("lol");
        _messages = updatedMessages;
        notifyListeners();
      }
      setBusy(false);
    });
  }

  Future addMessageToCurrentGroup(String groupId, String value) async {
    _firestoreService.addMessageToCurrentGroup(
      currentUser: _authenticationService.currentUser,
      value: value,
      groupId: groupId,
    );
  }
}
