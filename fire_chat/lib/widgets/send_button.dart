import 'package:flutter/material.dart';

class SendButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;

  const SendButton({this.text, this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: FlatButton(
        color: Colors.orange,
        onPressed: callback,
        child: Text(text),
      ),
    );
  }
}
