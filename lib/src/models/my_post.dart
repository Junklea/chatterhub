import 'package:flutter/material.dart';

class MyPost {
  final String title;
  final String imageUrl;
  final String userId;
  final String documentId;

  MyPost({
    @required this.userId,
    @required this.title,
    this.documentId,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'title': title,
      'imageUrl': imageUrl,
    };
  }

  static MyPost fromMap(Map<String, dynamic> map, String documentId) {
    if (map == null) return null;

    return MyPost(
      title: map['title'],
      imageUrl: map['imageUrl'],
      userId: map['userId'],
      documentId: documentId,
    );
  }
}
