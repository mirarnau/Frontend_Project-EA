import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  var text = "Customer";

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
      title: const Text(
        "Incorrect credentials",
        style: TextStyle(color: Colors.red),
      ),
      content: const Text("User not found or incorrect password."),
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
      backgroundColor: Colors.white,
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
                      'APPétit',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 213, 67, 67)),
                    )
                    //Image.asset('assets/images/like.png')),
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: customernameController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 57, 57, 57),
                  border: OutlineInputBorder(),
                  labelText: 'User name',
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0)
                  ),
                )
              )),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    controller: customernameController,
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(255, 57, 57, 57),
                        border: OutlineInputBorder(),
                        labelText: 'User name',
                        labelStyle:
                            TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        hintText: 'Enter your user name'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(255, 57, 57, 57),
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        labelStyle:
                            TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        hintText: 'Enter your password'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forgot Password?',
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
                    child: const Text(
                      'Login',
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
                  child: const Text(
                    'New User? Create Account',
                    style: TextStyle(
                      color: Colors.red
                    ),),
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
                    child: const Text("Owner",
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
                      child: const Text("Customer",
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
