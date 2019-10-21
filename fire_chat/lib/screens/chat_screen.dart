import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = '/chat';
  final FirebaseUser user;

  const ChatScreen(this.user);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fire Chat'),
      ),
      body: Center(
        child: Text('Chat'),
      ),
    );
  }
}
