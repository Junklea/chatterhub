import 'package:flutter/material.dart';

class MyChatRoom {
  final String title;
  final String imageUrl;
  final String documentId;

  MyChatRoom({
    @required this.title,
    this.documentId,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'imageUrl': imageUrl,
    };
  }

  static MyChatRoom fromMap(Map<String, dynamic> map, String documentId) {
    if (map == null) return null;

    return MyChatRoom(
      title: map['title'],
      imageUrl: map['imageUrl'],
      documentId: documentId,
    );
  }
}
