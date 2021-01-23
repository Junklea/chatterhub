import 'package:chatterhub/src/services/authentication_service.dart';
import 'package:chatterhub/src/services/firestore_service.dart';
import 'package:chatterhub/src/ui/widgets/message_form.dart';
import 'package:chatterhub/src/ui/widgets/message_wall.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    final User user = context.read<AuthenticationService>().currentUser;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("ChatterHub"),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.keyboard_return),
              onPressed: context.read<AuthenticationService>().signOut,
            ),
          ],
        ),
        backgroundColor: Color(0xffdee2d6),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: context
                    .read<FirestoreService>()
                    .messageStore
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.docs.isEmpty) {
                      return Center(
                        child: Text('Woah... So dusty.'),
                      );
                    }
                    return MessageWall(
                      messages: snapshot.data.docs,
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            Container(
              child: MessageForm(
                onSubmit: (value) {
                  context.read<FirestoreService>().addMessage(
                        currentUser: user,
                        value: value,
                      );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
