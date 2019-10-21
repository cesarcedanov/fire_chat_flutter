import 'package:flutter/material.dart';
import './widgets/custom_button.dart';
import './screens/login_screen.dart';
import './screens/registration_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fire Chat',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: MyHome(),
      routes: {
        MyHome.routeName: (ctx) => MyHome(),
        LoginScreen.routeName: (ctx) => LoginScreen(),
        RegistrationScreen.routeName: (ctx) => RegistrationScreen(),
//        ChatScreen.routeName: (ctx) => ChatScreen(),
      },
    );
  }
}

class MyHome extends StatelessWidget {
  static const routeName = '/home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: 'fire_logo',
                child: Container(
                  width: 50,
                  height: 50,
                  child: Image.asset(
                    'assets/images/fire_logo_transparent.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                'Fire Chat',
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          CustomButton(
              text: 'Log in',
              callback: () {
                Navigator.of(context).pushNamed(LoginScreen.routeName);
              }),
          CustomButton(
              text: 'Register',
              callback: () {
                Navigator.of(context).pushNamed(RegistrationScreen.routeName);
              }),
        ],
      ),
    );
  }
}
