import 'package:chatterhub/src/services/authentication_service.dart';
import 'package:chatterhub/src/services/firestore_service.dart';
import 'package:chatterhub/src/ui/widgets/chat_message.dart';
import 'package:chatterhub/src/ui/widgets/chat_message_other.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageWall extends StatefulWidget {
  final List<QueryDocumentSnapshot> messages;

  const MessageWall({Key key, this.messages}) : super(key: key);

  @override
  _MessageWallState createState() => _MessageWallState();
}

class _MessageWallState extends State<MessageWall> {
  bool shouldDisplayAvatar(int idx) {
    if (idx == widget.messages.length - 1) return true;
    return widget.messages[idx + 1].data()['author_id'] !=
        widget.messages[idx].data()['author_id'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        reverse: true,
        itemCount: widget.messages.length,
        itemBuilder: (context, index) {
          if (context.read<AuthenticationService>().currentUser.uid ==
              widget.messages[index].data()['author_id']) {
            return Dismissible(
              onDismissed: (_) {
                context
                    .read<FirestoreService>()
                    .deleteMessage(messageId: widget.messages[index].id);
              },
              key: ValueKey(widget.messages[index].data()['timestamp']),
              child: ChatMessage(
                index: index,
                data: widget.messages[index].data(),
                showAvatar: shouldDisplayAvatar(index),
              ),
            );
          } else {
            return Dismissible(
              onDismissed: (_) {
                context
                    .read<FirestoreService>()
                    .deleteMessage(messageId: widget.messages[index].id);
              },
              key: ValueKey(widget.messages[index].data()['timestamp']),
              child: ChatMessageOther(
                index: index,
                data: widget.messages[index].data(),
                showAvatar: shouldDisplayAvatar(index),
              ),
            );
          }
        },
      ),
    );
  }
}
