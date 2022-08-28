import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:salondec/page/mainPage.dart';
import 'package:salondec/widgets/login/login_page.dart';

//This is related to "https://www.youtube.com/watch?v=4vKiJZNPhss&ab_channel=JohannesMilke"

class LoginScreen extends StatelessWidget {
  static const routeName = "/";

  const LoginScreen({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            print("가는중");
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print("문제있어용");
            return Center(child: Text("something went wrong"));
          } else if (snapshot.hasData) {
            print("로그인되어있어용");
            return MainPage();
          } else {
            print("로그인하러가용");
            return LoginPage();
          }
        });
  }
}
