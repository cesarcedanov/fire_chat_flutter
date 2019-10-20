import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback callback;
  final String text;

  const  CustomButton({this.callback, this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.transparent,
      child: Material(
        color: Colors.orangeAccent,
        elevation: 4,
        borderRadius: BorderRadius.circular(30),
        child: MaterialButton(
          onPressed: callback,
          minWidth: 200,
          height: 45,
          child: Text(text),
        ),
      ),
    );
  }
}
