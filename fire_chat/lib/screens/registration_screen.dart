import 'package:fire_chat/screens/chat_screen.dart';
import 'package:fire_chat/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  static const routeName = '/registration';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String email;
  String password;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> registerUser() async {
    FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ))
        .user;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => ChatScreen(user),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Fire Chat'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Hero(
                  tag: 'fire_logo',
                  child: Container(
                    child:
                        Image.asset('assets/images/fire_logo_transparent.png'),
                  )),
            ),
            SizedBox(
              height: 40,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) => email = value,
              decoration: InputDecoration(
                  hintText: 'Enter your Email',
                  border: const OutlineInputBorder()),
            ),
            SizedBox(
              height: 40,
            ),
            TextField(
              obscureText: true,
              autocorrect: false,
              onChanged: (value) => password = value,
              decoration: InputDecoration(
                  hintText: 'Enter your Password',
                  border: const OutlineInputBorder()),
            ),
            CustomButton(
              text: 'Register',
              callback: () async {
                try {
                  await registerUser();
                } catch (error) {
                  print(error);
                }
              },
            )
          ],
        ));
  }
}
