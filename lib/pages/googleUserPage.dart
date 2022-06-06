import 'package:flutter/material.dart';
import 'package:flutter_tutorial/models/owner.dart';
import 'package:flutter_tutorial/pages/googleLoginPage.dart';
import 'package:flutter_tutorial/pages/spashPage.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_tutorial/pages/loginPage.dart';
import 'package:flutter_tutorial/pages/mainPage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_tutorial/services/customerService.dart';
import 'package:flutter_tutorial/models/customer.dart';
import 'package:flutter_tutorial/services/ownerService.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _errorMessage = '';
  String _errorMessagecustName = '';
  final customernameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordRepeatController = TextEditingController();
  bool isOwner = false;
  static const keyLanguage = 'key-language';
  bool buttonEnabled = false;
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
  void dispose() {
    // Clean up the controller when the widget is disposed.
    customernameController.dispose();
    passwordController.dispose();
    passwordRepeatController.dispose();

    super.dispose();
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text(
        "Error",
        style: TextStyle(color: Colors.red),
      ),
      content: Text(translate('login_page.password_match')),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    CustomerService customerService = CustomerService();
    OwnerService ownerService = OwnerService();
    /*return gotProfile
        ? Scaffold(
            appBar: AppBar(
              title: Text(" Welcome to Appetit " + account!.displayName! + "!"),
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
              ],
            ),
          )
        : LinearProgressIndicator();*/
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 80),
            Icon(Icons.login),
            SizedBox(width: 10),
            Text(translate('login_page.register'))
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 25.0),
              child: Center(
                child: SizedBox(
                    width: 300,
                    height: 80,
                    child: Text(
                      translate('login_page.register').toUpperCase(),
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    )
                    //Image.asset('assets/images/like.png')),
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: customernameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: translate('login_page.username'),
                    hintText: translate('login_page.enter_user')),
                onChanged: (val) {
                  validation(val);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 10, bottom: 0),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: translate('login_page.password'),
                    hintText: translate('login_page.enter_pass')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                controller: passwordRepeatController,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: translate('login_page.password_repeat'),
                    hintText: translate('login_page.password_again')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 10.0, bottom: 40.0),
              child: buildLanguage(context: context),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () async {
                  if ((customernameController.text.isNotEmpty) &&
                      (account!.displayName!.isNotEmpty) &&
                      (account!.email.isNotEmpty) &&
                      (passwordController.text.isNotEmpty) &&
                      (passwordRepeatController.text.isNotEmpty) &&
                      (isOwner == false)) {
                    setState(() {
                      buttonEnabled = true;
                    });
                    if (passwordController.text ==
                        passwordRepeatController.text) {
                      Customer newCustomer = Customer(
                          customerName: customernameController.text,
                          fullName: account!.displayName!,
                          email: account!.email,
                          profilePic: account!.photoUrl!,
                          //profilePic: Image.asset("assets/images/userDefaultPic.png"),
                          password: passwordController.text);
                      await customerService.addCustomer(newCustomer);

                      List<String> voidListTags = [];

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    } else {
                      showAlertDialog(context);
                    }
                  }
                  if ((customernameController.text.isNotEmpty) &&
                      (account!.displayName!.isNotEmpty) &&
                      (account!.email.isNotEmpty) &&
                      (passwordController.text.isNotEmpty) &&
                      (passwordRepeatController.text.isNotEmpty) &&
                      (isOwner == true)) {
                    setState(() {
                      buttonEnabled = true;
                    });
                    if (passwordController.text ==
                        passwordRepeatController.text) {
                      Owner newOwner = Owner(
                          ownerName: customernameController.text,
                          fullName: account!.displayName!,
                          email: account!.email,
                          password: passwordController.text);
                      await ownerService.addOwner(newOwner);

                      List<String> voidListTags = [];

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    } else {
                      showAlertDialog(context);
                    }
                  }
                },
                child: Text(
                  translate('login_page.register'),
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            const SizedBox(
              height: 130,
            ),
            Container(
              height: 50,
              width: 250,
              padding: const EdgeInsets.only(left: 0, bottom: 0),
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () async {
                  isOwner = true;
                  print(isOwner);
                },
                child: const Text("Owner",
                    style: TextStyle(color: Colors.black, fontSize: 25)),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              padding: const EdgeInsets.only(right: 0, bottom: 0),
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () async {
                  isOwner = false;
                  print(isOwner);
                },
                child: const Text("Customer",
                    style: TextStyle(color: Colors.black, fontSize: 25)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getProfile() async {
    await googleSignIn.signInSilently();
    account = googleSignIn.currentUser;
    auth = await account?.authentication;
    setState(() {
      gotProfile = true;
    });
  }

  void validation(String val) {
    if (val.isEmpty) {
      setState(() {
        _errorMessage = "Null value";
        buttonEnabled = false;
      });
    } else {
      setState(() {
        _errorMessage = "";
      });
    }
  }

  Widget buildLanguage({required BuildContext context}) => DropDownSettingsTile(
        settingKey: keyLanguage,
        title: translate('language.title'),
        selected: 1,
        values: <int, String>{
          1: translate('language.name.en'),
          2: translate('language.name.es'),
          3: translate('language.name.ca'),
        },
        onChange: (language) {
          if (language == 1) changeLocale(context, 'en');
          if (language == 2) changeLocale(context, 'es');
          if (language == 3) changeLocale(context, 'ca');
        },
      );
}
