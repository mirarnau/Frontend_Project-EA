// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_tutorial/pages/mainPage.dart';
import 'package:flutter_tutorial/pages/ownerMainPage.dart';
import 'package:flutter_tutorial/pages/spashPage.dart';
import 'package:flutter_tutorial/pages/profilePage.dart';
import 'package:flutter_tutorial/pages/googleUserPage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:flutter_tutorial/pages/registerPage.dart';

import 'package:flutter_tutorial/services/customerService.dart';
import 'package:flutter_tutorial/services/loginService.dart';
import 'package:flutter_tutorial/models/customer.dart';
import 'package:flutter_tutorial/models/owner.dart';
import 'package:flutter_tutorial/services/ownerService.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GoogleSignIn googleSignIn = GoogleSignIn(
      clientId:
          "79669730387-kilip5sabi811uct6r0f132olbu6k07h.apps.googleusercontent.com");
  final customernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool isOwner = false;
  var text = translate('customer');

  bool buttonEnabled = false;
  bool _isDarkMode = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    customernameController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  

  showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        translate('login_page.credentials'),
        style: TextStyle(color: Colors.red),
      ),
      content: Text(translate('login_page.not_found')),
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
    LoginService loginService = LoginService();
    OwnerService ownerService = OwnerService();

  return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Theme.of(context).canvasColor,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[Padding(
                padding: EdgeInsets.only(top: 70.0),
                child: Center(
                  child: Container(
                    height: 200.0,
                    width: 200.0,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/appetit.png'),
                        fit: BoxFit.fill,
                      ),
                      shape: BoxShape.rectangle,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: TextField(
                  controller: customernameController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Theme.of(context).hintColor,
                      border: OutlineInputBorder(),
                      labelText: translate('login_page.username'),
                      labelStyle:
                          TextStyle(color: Theme.of(context).highlightColor),
                      hintText: translate('login_page.enter_user'),
                      hintStyle: 
                          TextStyle(color: Theme.of(context).highlightColor)
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Theme.of(context).hintColor,
                      border: OutlineInputBorder(),
                      labelText: translate('login_page.password'),
                      labelStyle:
                          TextStyle(color: Theme.of(context).highlightColor),
                      hintText: translate('login_page.enter_pass'),
                      hintStyle: 
                          TextStyle(color: Theme.of(context).highlightColor)),
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    translate('login_page.forgot_pass'),
                    style: TextStyle(color: Colors.red, fontSize: 15),
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  style: TextButton.styleFrom(
                      primary: Theme.of(context).primaryColor),
                  onPressed: () async {
                    if ((customernameController.text.isNotEmpty) &&
                        (passwordController.text.isNotEmpty) &&
                        (isOwner == false)) {
                      setState(() {
                        buttonEnabled = true;
                      });
                      var res = await loginService.loginCustomer(
                          customernameController.text,
                          passwordController.text);
                      if (res == "401") {
                        showAlertDialog(context);
                        return;
                      }

                  List<String> voidListTags = [];

                  Customer? customer = await customerService
                      .getCustomerByName(customernameController.text);

                  var route = MaterialPageRoute(
                      builder: (BuildContext context) => MainPage(
                            customer: customer,
                            selectedIndex: 0,
                            transferRestaurantTags: voidListTags,
                            chatPage: "Inbox",
                          ));

                  if (customer == null) {
                    showAlertDialog(context);
                    return;
                  }

                  Navigator.of(context).push(route);
                }
                if ((customernameController.text.isNotEmpty) &&
                    (passwordController.text.isNotEmpty) &&
                    (isOwner == true)) {
                  setState(() {
                    buttonEnabled = true;
                  });
                  var res = await loginService.loginOwner(
                      customernameController.text, passwordController.text);
                  if (res == "400" || res == "401") {
                    showAlertDialog(context);
                    return;
                  }
                  List<String> voidListTags = [];

                      Owner? owner = await ownerService
                          .getOwnerByName(customernameController.text);
                      if (owner == null) {
                        showAlertDialog(context);
                        return null;
                      }
                      var routes = MaterialPageRoute(
                          builder: (BuildContext context) =>
                              OwnerMainPage(
                                owner: owner,
                                selectedIndex: 0,
                                transferRestaurantTags: voidListTags,
                                chatPage: "Inbox",
                              ));
                      Navigator.of(context).push(routes);
                    }
                  },
                  child: Text(
                    translate('login_page.login'),
                    style: TextStyle(color: Theme.of(context).canvasColor, fontSize: 25),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: TextButton(
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterPage()),
                      );
                    },
                    child: Text(
                      translate('login_page.new_user'),
                      style: TextStyle(color: Colors.amber),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: TextButton(
                    onPressed: () {
                      stratrSignIn();
                    },
                    child: const Text(
                      'Sign In with Google',
                      style: TextStyle(color: Colors.amber),
                    ),
                  ),
                ),
              ),
              ToggleSwitch(
                minWidth: 90.0,
                initialLabelIndex: 0,
                cornerRadius: 20.0,
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.grey,
                inactiveFgColor: Colors.white,
                totalSwitches: 2,
                labels: ['Customer', 'Owner'],
                activeBgColors: [[Colors.blue],[Colors.red]],
                onToggle: (index) {
                  if (index == 0){
                    isOwner = false;
                  }
                  else{
                    isOwner = true;
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> save_data(fullName, email, customerName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('fullName', fullName);
    await prefs.setString('email', email);
    await prefs.setString('customerName', customerName);
  }

  String customerName = '';
  String password = '';
  late Customer customer;

  Future<void> navigate() async {
    CustomerService customerService = CustomerService();
    LoginService loginService = LoginService();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    customerName = (await prefs.getString('customerName')!);
    password = (await prefs.getString('password')!);
    if (customerName != '') {
      Customer? sharedcustomer = (await loginService.loginCustomer(
          customerName, password)) as Customer?;
      var route = MaterialPageRoute(
        builder: (BuildContext context) => ProfilePage(
          customer: customer,
        ),
      );
      Navigator.of(context).push(route);
    }
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

  @override
  void initState() {
    super.initState();
  }
}
