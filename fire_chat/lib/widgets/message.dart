import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  final String from;
  final String text;

  final bool isFromCurrentUser;

  const Message({this.from, this.text, this.isFromCurrentUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: isFromCurrentUser
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: <Widget>[
          Text(from),
          Material(
            color: isFromCurrentUser ? Colors.redAccent : Colors.teal,
            borderRadius: BorderRadius.circular(10),
            elevation: 6,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Text(text),
            ),
          )
        ],
      ),
    );
  }
}
