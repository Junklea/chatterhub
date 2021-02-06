import 'package:chatterhub/src/models/my_message.dart';
import 'package:flutter/material.dart';

class ChatMessageOther extends StatelessWidget {
  final int index;
  final MyMessage data;
  final bool showAvatar;

  const ChatMessageOther(
      {Key key, this.index, this.data, this.showAvatar = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 4,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          showAvatar
              ? CircleAvatar(
                  backgroundImage: NetworkImage('https://picsum.photos/40'),
                )
              : SizedBox(
                  width: 40,
                ),
          SizedBox(width: 10),
          Container(
            constraints: BoxConstraints(maxWidth: 300),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (showAvatar)
                  Text(
                    '${data.userName} said: ',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontStyle: FontStyle.italic,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                if (showAvatar) SizedBox(height: 5),
                Text(data.content),
              ],
            ),
          )
        ],
      ),
    );
  }
}
