import 'package:chatterhub/src/models/todo.dart';
import 'package:chatterhub/src/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoCard extends StatefulWidget {
  final TodoModel todo;
  final String uid;

  const TodoCard({Key key, this.todo, this.uid}) : super(key: key);

  @override
  _TodoCardState createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<FirestoreService>().deleteTodo(
            uid: widget.uid,
            todoId: widget.todo.todoId,
          ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.todo.content,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
