import 'package:flutter/material.dart';

class MessageForm extends StatefulWidget {
  final ValueChanged<String> onSubmit;

  MessageForm({Key key, this.onSubmit}) : super(key: key);

  @override
  _MessageFormState createState() => _MessageFormState();
}

class _MessageFormState extends State<MessageForm> {
  String _message;
  final _controller = TextEditingController();

  void _onPressed() {
    widget.onSubmit(_message);
    _controller.clear();
    setState(() {
      _message = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      // color: Colors.blue,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Type a message",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.all(10),
              ),
              minLines: 1,
              maxLines: 10,
              onChanged: (value) {
                setState(() {
                  _message = value;
                });
              },
            ),
          ),
          SizedBox(width: 5),
          RawMaterialButton(
            onPressed:
                _message == null || _message.isEmpty ? () {} : _onPressed,
            fillColor: _message == null || _message.isEmpty
                ? Colors.blueGrey
                : Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "SEND",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
