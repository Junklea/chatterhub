import 'package:chatterhub/src/models/my_chatroom.dart';
import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
  final MyChatRoom chatRoom;
  final goToGroup;

  const ChatItem({Key key, @required this.chatRoom, this.goToGroup})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        goToGroup(chatRoom.documentId);
      },
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
        title: Text(
          chatRoom.title,
          maxLines: 1,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
