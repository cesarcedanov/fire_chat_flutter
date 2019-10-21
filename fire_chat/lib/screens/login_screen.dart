import '../widgets/custom_button.dart';
import 'chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> loginUser() async {
    FirebaseUser user = (await _auth.signInWithEmailAndPassword(
            email: email, password: password))
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
              text: 'Login',
              callback: () async {
                try {
                  await loginUser();
                } catch (error) {
                  print(error.toString());
                }
              },
            )
          ],
        ));
  }
}
