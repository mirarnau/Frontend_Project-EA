// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_tutorial/pages/mainPage.dart';
import 'package:flutter_tutorial/pages/ownerMainPage.dart';

import 'package:flutter_tutorial/pages/profilePage.dart';

import 'package:flutter_tutorial/pages/registerPage.dart';

import 'package:flutter_tutorial/services/customerService.dart';
import 'package:flutter_tutorial/services/loginService.dart';
import 'package:flutter_tutorial/models/customer.dart';
import 'package:flutter_tutorial/models/owner.dart';
import 'package:flutter_tutorial/services/ownerService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final customernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool isOwner = false;
  var text = translate('customer');

  bool buttonEnabled = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    customernameController.dispose();
    passwordController.dispose();

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
        color: const Color.fromARGB(255, 48, 48, 48),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 100.0),
                child: Center(
                  child: SizedBox(
                      width: 200,
                      height: 150,
                      child: Text(
                        'Appétit',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 213, 67, 67)),
                      )
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    controller: customernameController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(255, 57, 57, 57),
                        border: OutlineInputBorder(),
                        labelText: translate('login_page.username'),
                        labelStyle:
                            TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        hintText: translate('login_page.enter_user')),
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
                        fillColor: Color.fromARGB(255, 57, 57, 57),
                        border: OutlineInputBorder(),
                        labelText: translate('login_page.password'),
                        labelStyle:
                            TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        hintText: translate('login_page.enter_pass')),
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
                      color: const Color.fromARGB(255, 213, 67, 67),
                      borderRadius: BorderRadius.circular(20)),
                  child: TextButton(
                    style: TextButton.styleFrom(
                        primary: const Color.fromARGB(255, 213, 67, 67)),
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
                      builder: (BuildContext context) =>
                          MainPage(customer: customer, selectedIndex: 0, transferRestaurantTags: voidListTags, chatPage: "Inbox",));

                        if (customer == null) {
                          showAlertDialog(context);
                          return;
                        }

                        Navigator.of(context).push(route);

                        /*
                    save_data(customer.fullName, customer.email,
                        customer.customerName);
                    var route = MaterialPageRoute(f73af5b871
                      builder: (BuildContext context) => ProfilePage(
                          fullName: customer.fullName,
                          email: customer.email,
                          customerName: customer.customerName),
                    );
                    Navigator.of(context).push(route);*/
                      }
                      if ((customernameController.text.isNotEmpty) &&
                          (passwordController.text.isNotEmpty) &&
                          (isOwner == true)) {
                        setState(() {
                          buttonEnabled = true;
                        });
                        var res = await loginService.loginOwner(
                            customernameController.text,
                            passwordController.text);
                        if (res == "401") {
                          showAlertDialog(context);
                          return;
                        }
                        Owner? owner = await ownerService
                            .getOwnerByName(customernameController.text);
                        if (owner == null) {
                          showAlertDialog(context);
                          return null;
                        }
                        var routes = MaterialPageRoute(
                            builder: (BuildContext context) =>
                                OwnerMainPage(owner: owner));
                        Navigator.of(context).push(routes);
                      }
                    },
                    child: Text(
                      translate('login_page.login'),
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 70),
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
                Container(
                  height: 50,
                  width: 250,
                  padding: const EdgeInsets.only(left: 0, bottom: 0),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20)),
                  child: TextButton(
                    onPressed: () async {
                      isOwner = true;
                      print(isOwner);
                    },
                    child: Text(translate('owner'),
                        style: TextStyle(color: Colors.black, fontSize: 25)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 50,
                    width: 250,
                    padding: const EdgeInsets.only(right: 0, bottom: 0),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20)),
                    child: TextButton(
                      onPressed: () async {
                        isOwner = false;
                        print(isOwner);
                      },
                      child: Text(translate('customer'),
                          style: TextStyle(color: Colors.black, fontSize: 25)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
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

  @override
  void initState() {
    super.initState();
  }
}
