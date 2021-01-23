import 'package:chatterhub/src/models/todo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _firestore;

  CollectionReference get messageStore =>
      _firestore.collection('chat_messages');

  FirestoreService(this._firestore);

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
