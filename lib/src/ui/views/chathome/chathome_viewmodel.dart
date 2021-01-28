import 'package:chatterhub/src/app/locator.dart';
import 'package:chatterhub/src/models/my_chatroom.dart';
import 'package:chatterhub/src/services/firestore_service.dart';
import 'package:chatterhub/src/ui/views/base_model.dart';

class ChatHomeViewModel extends BaseModel {
  final FirestoreService _firestoreService = getIt<FirestoreService>();

  List<MyChatRoom> _chatRooms;
  List<MyChatRoom> get chatRooms => _chatRooms;

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
}
