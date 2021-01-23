import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String content;
  String senderId;
  String senderName;

  MessageModel({
    this.content,
    this.senderId,
    this.senderName,
  });

  MessageModel.fromDocumentSnapshot({DocumentSnapshot documentSnapshot}) {
    content = documentSnapshot.data()['content'] as String;
    senderId = documentSnapshot.data()['senderId'] as String;
    senderName = documentSnapshot.data()['senderName'] as String;
  }
}
