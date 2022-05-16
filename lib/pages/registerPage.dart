import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tutorial/pages/loginPage.dart';
import 'package:flutter_tutorial/pages/mainPage.dart';
import 'package:flutter_tutorial/services/customerService.dart';
import 'package:flutter_tutorial/models/customer.dart';
import 'package:flutter_tutorial/services/ownerService.dart';

import '../models/owner.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final customernameController = TextEditingController();
  final fullnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordRepeatController = TextEditingController();
  bool _switchValue=true;
  bool isOwner = false;

  bool buttonEnabled = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    customernameController.dispose();
    fullnameController.dispose();
    emailController.dispose();
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
      content: const Text("Passwords don't match"),
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

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            SizedBox(width: 80),
            Icon(Icons.login),
            SizedBox(width: 10),
            Text('Register')
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 40.0),
              child: Center(
                child: SizedBox(
                    width: 200,
                    height: 90,
                    child: Text(
                      'REGISTER',
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
                controller: fullnameController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Full name ',
                    hintText: 'Enter your full name'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter your email'),
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
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 50),
              child: TextField(
                controller: passwordRepeatController,
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Repeat password',
                    hintText: 'Enter your password again'),
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
                      (fullnameController.text.isNotEmpty) &&
                      (emailController.text.isNotEmpty) &&
                      (passwordController.text.isNotEmpty) &&
                      (passwordRepeatController.text.isNotEmpty) && (isOwner == false)) {
                    setState(() {
                      buttonEnabled = true;
                    });
                    if (passwordController.text ==
                        passwordRepeatController.text) {
                      Customer newCustomer = Customer(
                          customerName: customernameController.text,
                          fullName: fullnameController.text,
                          email: emailController.text,
                          password: passwordController.text);
                      await customerService.addCustomer(newCustomer);

                      List<String> voidListTags=[];

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                LoginPage()),
                      );
                    } else {
                      showAlertDialog(context);
                    }
                  }
                  if ((customernameController.text.isNotEmpty) &&
                      (fullnameController.text.isNotEmpty) &&
                      (emailController.text.isNotEmpty) &&
                      (passwordController.text.isNotEmpty) &&
                      (passwordRepeatController.text.isNotEmpty) && (isOwner == true)){
                        setState(() {
                      buttonEnabled = true;
                    });
                    if (passwordController.text ==
                        passwordRepeatController.text) {
                      Owner newOwner = Owner(
                          ownerName: customernameController.text,
                          fullName: fullnameController.text,
                          email: emailController.text,
                          password: passwordController.text);
                      await ownerService.addOwner(newOwner);

                      List<String> voidListTags=[];

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                LoginPage()),
                      );
                    } else {
                      showAlertDialog(context);
                    }

                  }
                },
                child: const Text(
                  'Register',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            const SizedBox(
              height: 130,
            ),
            /*
            Container(
              height: 50,
              width: 250,
              padding: const EdgeInsets.only(left: 0, bottom: 0),
              decoration: BoxDecoration(
                  color:  Colors.red, 
                  borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () async {
                    isOwner = true;
                    print(isOwner);
                },
                child: const Text("Owner",style: TextStyle(color: Colors.black, fontSize: 25)),
                
              ),
            ),
            Container(
              height: 50,
              width: 250,
              padding: const EdgeInsets.only(right: 0, bottom: 0),
              decoration: BoxDecoration(
                  color:  Colors.blue, 
                  borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () async {
                    isOwner = false;
                    print(isOwner);
                },
                child: const Text("Customer",style: TextStyle(color: Colors.black, fontSize: 25)),
                
              ),
            ),
            */
          ],
          
        ),
      ),
    );
  }
}
