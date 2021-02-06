import 'package:chatterhub/src/app/locator.dart';
import 'package:chatterhub/src/app/router.gr.dart';
import 'package:chatterhub/src/enum/dialog_type.dart';
import 'package:chatterhub/src/models/my_chatroom.dart';
import 'package:chatterhub/src/services/authentication_service.dart';
import 'package:chatterhub/src/services/firestore_service.dart';
import 'package:chatterhub/src/ui/views/base_model.dart';
import 'package:stacked_services/stacked_services.dart';

class ChatHomeViewModel extends BaseModel {
  final FirestoreService _firestoreService = getIt<FirestoreService>();
  final NavigationService _navigationService = getIt<NavigationService>();
  final AuthenticationService _authenticationService =
      getIt<AuthenticationService>();
  final DialogService _dialogService = getIt<DialogService>();

  List<MyChatRoom> _chatRooms;
  List<MyChatRoom> get chatRooms => _chatRooms;

  Future<void> goToGroup(String id) async {
    final MyChatRoom curChatRoom = await _firestoreService.getChatRoom(id);
    // print(curChatRoom.toMap());

    _navigationService.navigateTo(
      Routes.groupView,
      arguments: GroupViewArguments(
        group: curChatRoom,
      ),
    );
  }

  Future<void> signOut() async {
    _authenticationService.signOut();
    _navigationService.clearTillFirstAndShow(Routes.signUpView);
  }

  void listenToChatRooms() {
    setBusy(true);
    _firestoreService.listenToChatRooms().listen((chatRoomsData) {
      List<MyChatRoom> updatedChatRooms = chatRoomsData;
      if (updatedChatRooms != null && updatedChatRooms.length > 0) {
        _chatRooms = updatedChatRooms;
        notifyListeners();
      }
      setBusy(false);
    });
  }

  Future addGroup() async {
    var response = await _dialogService.showCustomDialog(
      title: 'Enter group name',
      mainButtonTitle: 'Done',
      variant: DialogType.Form,
    );
    if (response.responseData[0] != '') {
      await _firestoreService.createGroup(response.responseData[0]);
    }
    print(response.responseData[0]);
  }
}
