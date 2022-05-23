import 'package:flutter/material.dart';
import 'package:flutter_tutorial/pages/googleLoginPage.dart';
import 'package:flutter_tutorial/pages/spashPage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  GoogleSignIn googleSignIn = GoogleSignIn(
      clientId:
          "79669730387-kilip5sabi811uct6r0f132olbu6k07h.apps.googleusercontent.com");
  GoogleSignInAccount? account;
  GoogleSignInAuthentication? auth;
  bool gotProfile = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return gotProfile
        ? Scaffold(
            appBar: AppBar(
              title: Text(" Your Profile "),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () async {
                    await googleSignIn.signOut();
                    var route = MaterialPageRoute(
                        builder: (BuildContext context) => SplashScreen());
                    Navigator.of(context).push(route);
                  },
                  icon: Icon(Icons.exit_to_app),
                ),
              ],
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.network(
                  account!.photoUrl!,
                  height: 150,
                ),
                Text(account!.displayName!),
                Text(account!.email),
                Text(auth!.idToken!)
              ],
            ),
          )
        : LinearProgressIndicator();
  }

  void getProfile() async {
    await googleSignIn.signInSilently();
    account = googleSignIn.currentUser;
    auth = await account?.authentication;
    setState(() {
      gotProfile = true;
    });
  }
}
