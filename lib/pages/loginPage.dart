import 'package:flutter/material.dart';
import 'package:flutter_tutorial/pages/mainPage.dart';

import 'package:flutter_tutorial/pages/profilePage.dart';

import 'package:flutter_tutorial/pages/registerPage.dart';

import 'package:flutter_tutorial/services/customerService.dart';
import 'package:flutter_tutorial/models/customer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final customernameController = TextEditingController();
  final passwordController = TextEditingController();

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

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.login),
            SizedBox(width: 10),
            Text('Login')
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 60.0),
              child: Center(
                child: SizedBox(
                    width: 200,
                    height: 150,
                    child: Text(
                      'LOGIN',
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
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'User name',
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
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter your password'),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Forgot Password',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () async {
                  if ((customernameController.text.isNotEmpty) &&
                      (passwordController.text.isNotEmpty)) {
                    setState(() {
                      buttonEnabled = true;
                    });
                    Customer? customer = await customerService.login(
                        customernameController.text, passwordController.text);
                    if (customer == null) {
                      showAlertDialog(context);
                      return;
                    }
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MainPage()),
                    );*/
                    var route = MaterialPageRoute(
                      builder: (BuildContext context) =>
                          MainPage(customer: customer),
                    );
                    Navigator.of(context).push(route);

                    //save_data(customer);
                    /*var route = MaterialPageRoute(
                      builder: (BuildContext context) => ProfilePage(
                        customer: customer,
                      ),
                    );
                    Navigator.of(context).push(route);*/
                  }
                },
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            const SizedBox(
              height: 130,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: TextButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterPage()),
                  );
                },
                child: const Text('New User? Create Account'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /*Future<void> save_data(Customer customer) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('fullName', customer.fullName);
    await prefs.setString('email', customer.email);
    await prefs.setString('customerName', customer.customerName);
  }
  String fullName = '';
  String email = '';
  String customerName = '';
  late Customer customer;
  Future<void> navigate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    fullName = (await prefs.getString('fullName'))!;
    email = (await prefs.getString('email')!);
    customerName = (await prefs.getString('customerName')!);
    if (fullName != '') {
      var route = MaterialPageRoute(
        builder: (BuildContext context) => ProfilePage(
          customer: customer,
        ),
      );
      Navigator.of(context).push(route);
    }
  }*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //navigate();
  }
}
