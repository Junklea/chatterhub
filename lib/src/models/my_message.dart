import 'package:flutter/material.dart';

class MyMessage {
  final String content;
  final String imageUrl;
  final String userId;
  final String documentId;

  MyMessage({
    @required this.userId,
    @required this.content,
    this.documentId,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'content': content,
      'imageUrl': imageUrl,
    };
  }

  static MyMessage fromMap(Map<String, dynamic> map, String documentId) {
    if (map == null) return null;

    return MyMessage(
      content: map['content'],
      imageUrl: map['imageUrl'],
      userId: map['userId'],
      documentId: documentId,
    );
  }
}
