// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_tutorial/pages/googleUserPage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_tutorial/pages/googleLoginPage.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  GoogleSignIn googleSignIn = GoogleSignIn(
      clientId:
          "79669730387-kilip5sabi811uct6r0f132olbu6k07h.apps.googleusercontent.com");
  @override
  void initState() {
    checkSignInStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Welcome!",
            style: TextStyle(fontSize: 30),
          ),
          CircularProgressIndicator()
        ],
      ),
    );
  }

  void checkSignInStatus() async {
    await Future.delayed(Duration(seconds: 1));
    bool isSignedIn = await googleSignIn.isSignedIn();
    if (isSignedIn) {
      var route =
          MaterialPageRoute(builder: (BuildContext context) => ProfileScreen());
      Navigator.of(context).push(route);
    } else {
      var route =
          MaterialPageRoute(builder: (BuildContext context) => LoginScreen());
      Navigator.of(context).push(route);
    }
  }
}
