import 'package:flutter/material.dart';
import 'package:flutter_tutorial/pages/googleUserPage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GoogleSignIn googleSignIn = GoogleSignIn(
      clientId:
          "79669730387-kilip5sabi811uct6r0f132olbu6k07h.apps.googleusercontent.com");
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Sign in with Google!",
            style: TextStyle(fontSize: 30),
          ),
          ElevatedButton(
            onPressed: () {
              stratrSignIn();
            },
            child: Text('Tap to sign in'),
          ),
        ],
      ),
    );
  }

  void stratrSignIn() async {
    googleSignIn.signOut();
    GoogleSignInAccount? customer = await googleSignIn.signIn();
    if (customer == null) {
      print('Sign In Failed ');
    } else {
      var route =
          MaterialPageRoute(builder: (BuildContext context) => ProfileScreen());
      Navigator.of(context).push(route);
    }
  }
}
