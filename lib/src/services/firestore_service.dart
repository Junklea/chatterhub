import 'dart:async';

import 'package:chatterhub/src/models/my_chatroom.dart';
import 'package:chatterhub/src/models/my_message.dart';
import 'package:chatterhub/src/models/my_post.dart';
import 'package:chatterhub/src/models/my_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference get messageStore =>
      _firestore.collection('chat_messages');

  // Chat Rooms
  final CollectionReference _chatRoomsReferance =
      FirebaseFirestore.instance.collection("chat_rooms");

  Future<MyChatRoom> getChatRoom(String id) async {
    try {
      var userData = await _chatRoomsReferance.doc(id).get();
      return MyChatRoom.fromMap(userData.data(), userData.id);
    } catch (e) {
      return e.message;
    }
  }

  Future<void> createGroup(String groupName) async {
    try {
      await _chatRoomsReferance.add({
        'title': groupName,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      return e.message;
    }
  }

  final StreamController<List<MyChatRoom>> _chatRoomsController =
      StreamController<List<MyChatRoom>>.broadcast();

  Stream listenToChatRooms() {
    _chatRoomsReferance
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((chatRoomsSnapshot) {
      if (chatRoomsSnapshot.docs.isNotEmpty) {
        var chatRooms = chatRoomsSnapshot.docs
            .map((snapshot) => MyChatRoom.fromMap(snapshot.data(), snapshot.id))
            .where((mappedItem) => mappedItem.title != null)
            .toList();

        _chatRoomsController.add(chatRooms);
      }
    });

    return _chatRoomsController.stream;
  }

  final StreamController<List<MyMessage>> _messageController =
      StreamController<List<MyMessage>>.broadcast();

  // Get Messages by Group Doc Id
  Stream getMessagesByGroupDocId(String id) {
    _chatRoomsReferance
        .doc(id)
        .collection("messages")
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((chatMessagesSnapshot) {
      if (chatMessagesSnapshot.docs.isNotEmpty) {
        var messages = chatMessagesSnapshot.docs
            .map((e) => MyMessage.fromMap(e.data(), e.id))
            .where((element) => element.content != null)
            .toList();

        _messageController.add(messages);
      }
    });
    return _messageController.stream;
  }

  // Add messages to current group
  Future<void> addMessageToCurrentGroup(
      {String groupId, String value, MyUser currentUser}) async {
    final CollectionReference _currentGroupReferance =
        _chatRoomsReferance.doc(groupId).collection('messages');
    try {
      await _currentGroupReferance.add({
        'author': currentUser.email,
        'user_id': currentUser.id,
        'photo_url': 'https://placehold.it/100x100',
        // 'timestamp': Timestamp.now().microsecondsSinceEpoch,
        'timestamp': FieldValue.serverTimestamp(),
        'content': value,
        'userName': currentUser.fullName,
      });
      await _chatRoomsReferance.doc(groupId).update({
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      rethrow;
    }
  }

  // User
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection("users");

  Future createUser(MyUser user) async {
    try {
      await _usersCollectionReference.doc(user.id).set(user.toJson());
    } catch (e) {
      return e.message;
    }
  }

  Future getUser(String uid) async {
    try {
      var userData = await _usersCollectionReference.doc(uid).get();
      return MyUser.fromData(userData.data());
    } catch (e) {
      return e.message;
    }
  }

  // Posts
  final CollectionReference _postsCollectionReference =
      FirebaseFirestore.instance.collection('posts');

  Future addPost(MyPost post) async {
    try {
      await _postsCollectionReference.add(post.toMap());
      return true;
    } catch (e) {
      return e.toString();
    }
  }

  Future deletePost(String documentId) async {
    await _postsCollectionReference.doc(documentId).delete();
  }

  Future updatePost(MyPost post) async {
    try {
      await _postsCollectionReference.doc(post.documentId).update(post.toMap());
      return true;
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Future getPostsOnceOff() async {
    try {
      var postDocuments = await _postsCollectionReference.get();
      if (postDocuments.docs.isNotEmpty) {
        return postDocuments.docs
            .map((snapshot) => MyPost.fromMap(snapshot.data(), snapshot.id))
            .where((mappedItem) => mappedItem.title != null)
            .toList();
      }
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  final StreamController<List<MyPost>> _postsController =
      StreamController<List<MyPost>>.broadcast();

  Stream listenToPostsRealTime() {
    // Register the handler for when the posts data changes
    _postsCollectionReference.snapshots().listen((postsSnapshot) {
      if (postsSnapshot.docs.isNotEmpty) {
        var posts = postsSnapshot.docs
            .map((snapshot) => MyPost.fromMap(snapshot.data(), snapshot.id))
            .where((mappedItem) => mappedItem.title != null)
            .toList();

        // Add the posts onto the controller
        _postsController.add(posts);
      }
    });

    // Return the stream underlying our _postsController.
    return _postsController.stream;
  }
}
