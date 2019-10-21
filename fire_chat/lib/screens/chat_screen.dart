import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/send_button.dart';
import '../widgets/message.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = '/chat';
  final FirebaseUser user;

  const ChatScreen(this.user);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;

  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  Future<void> callBack() async {
    if (messageController.text.isNotEmpty) {
      await _firestore.collection('messages').add({
        'text': messageController.text,
        'from': widget.user.email,
        'sent_date': DateTime.now().toIso8601String(),
      });
      messageController.clear();
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Hero(
            tag: 'fire_logo',
            child: Container(
              child: Image.asset(
                'assets/images/fire_logo_transparent.png',
              ),
            ),
          ),
          title: Text('Fire Chat'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            )
          ],
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _firestore
                      .collection('messages')
                      .orderBy('sent_date')
                      .snapshots(),
                  builder: (ctx, snapshot) {
                    if (!snapshot.hasData)
                      return Center(child: CircularProgressIndicator());

                    List<DocumentSnapshot> docs = snapshot.data.documents;
                    List<Widget> messages = docs
                        .map((doc) => Message(
                              from: doc.data['from'],
                              text: doc.data['text'],
                              isFromCurrentUser:
                                  widget.user.email == doc.data['from'],
                            ))
                        .toList();
                    return ListView(
                      controller: scrollController,
                      children: <Widget>[...messages],
                    );
                  },
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        onSubmitted: (_) => callBack(),
                        controller: messageController,
                        decoration: InputDecoration(
                          hintText: 'Enter a Message...',
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SendButton(
                      text: 'Send',
                      callback: callBack,
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
