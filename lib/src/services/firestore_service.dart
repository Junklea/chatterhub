import 'dart:async';

import 'package:chatterhub/src/models/my_chatroom.dart';
import 'package:chatterhub/src/models/my_post.dart';
import 'package:chatterhub/src/models/my_user.dart';
import 'package:chatterhub/src/models/todo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  final StreamController<List<MyChatRoom>> _chatRoomsController =
      StreamController<List<MyChatRoom>>.broadcast();

  Stream listenToChatRooms() {
    _chatRoomsReferance.snapshots().listen((chatRoomsSnapshot) {
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

  // Legacy Message
  Future<void> addMessage({String value, User currentUser}) async {
    try {
      await messageStore.add({
        'author': currentUser.email,
        'author_id': currentUser.uid,
        'photo_url': 'https://placehold.it/100x100',
        'timestamp': Timestamp.now().microsecondsSinceEpoch,
        'value': value,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteMessage({String messageId}) async {
    try {
      await messageStore.doc(messageId).delete();
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<TodoModel>> streamTodos({String uid}) {
    try {
      return _firestore
          .collection("todos")
          .doc(uid)
          .collection("todos")
          .where("done", isEqualTo: false)
          .snapshots()
          .map((query) {
        final List<TodoModel> retVal = <TodoModel>[];
        for (final DocumentSnapshot doc in query.docs) {
          retVal.add(TodoModel.fromDocumentSnapshot(documentSnapshot: doc));
        }
        return retVal;
      });
    } catch (e) {
      rethrow;
    }
  }

  // Legacy Todo
  Future<void> addTodo({String uid, String content}) async {
    try {
      _firestore.collection("todos").doc(uid).collection("todos").add({
        "content": content,
        "done": false,
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateTodo({String uid, String todoId}) async {
    try {
      _firestore
          .collection("todos")
          .doc(uid)
          .collection("todos")
          .doc(todoId)
          .update({
        "done": true,
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteTodo({String uid, String todoId}) async {
    try {
      _firestore
          .collection("todos")
          .doc(uid)
          .collection("todos")
          .doc(todoId)
          .delete();
    } catch (e) {
      print(e);
    }
  }
}
