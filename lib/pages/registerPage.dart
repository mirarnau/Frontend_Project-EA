import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:flutter_translate/flutter_translate.dart';
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
  String _errorMessage = '';
  String _errorMessagecustName = '';
  final customernameController = TextEditingController();
  final fullnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordRepeatController = TextEditingController();
  bool _switchValue = true;
  bool isOwner = false;
  static const keyLanguage = 'key-language';
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
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
                          TextStyle(color: Theme.of(context).highlightColor, fontSize: 40, fontWeight: FontWeight.bold),
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
                  filled: true,
                  fillColor: Theme.of(context).hintColor, 
                  border: OutlineInputBorder(),
                  labelText: translate('login_page.username'),
                  hintText: translate('login_page.enter_user'),
                  labelStyle: TextStyle(color: Theme.of(context).highlightColor),
                  hintStyle: TextStyle(color: Theme.of(context).highlightColor)),
                onChanged: (val) {
                  validation(val);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Text(
                _errorMessagecustName,
                style: TextStyle(color: Colors.red),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 10, bottom: 0),
              child: TextField(
                controller: fullnameController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).hintColor, 
                    border: OutlineInputBorder(),
                    labelText: translate('login_page.fullname'),
                    hintText: translate('login_page.enter_full'),
                    labelStyle: TextStyle(color: Theme.of(context).highlightColor),
                    hintStyle: TextStyle(color: Theme.of(context).highlightColor)),
                onChanged: (val) {
                  validation(val);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Text(
                _errorMessagecustName,
                style: TextStyle(color: Colors.red),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 10, bottom: 0),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: translate('login_page.email'),
                    hintText: translate('login_page.enter_email'),
                    filled: true,
                    fillColor: Theme.of(context).hintColor, 
                    labelStyle: TextStyle(color: Theme.of(context).highlightColor),
                    hintStyle: TextStyle(color: Theme.of(context).highlightColor)),
                onChanged: (val) {
                  validateEmail(val);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
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
                    hintText: translate('login_page.enter_pass'),
                    filled: true,
                    fillColor: Theme.of(context).hintColor, 
                    labelStyle: TextStyle(color: Theme.of(context).highlightColor),
                    hintStyle: TextStyle(color: Theme.of(context).highlightColor)),
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
                    hintText: translate('login_page.password_again'),
                    filled: true,
                    fillColor: Theme.of(context).hintColor, 
                    labelStyle: TextStyle(color: Theme.of(context).highlightColor),
                    hintStyle: TextStyle(color: Theme.of(context).highlightColor)),
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
                  color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () async {
                  if ((customernameController.text.isNotEmpty) &&
                      (fullnameController.text.isNotEmpty) &&
                      (emailController.text.isNotEmpty) &&
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
                          fullName: fullnameController.text,
                          email: emailController.text,
                          profilePic: 'https://res.cloudinary.com/eduardferrecloud/image/upload/v1653992797/profilePics/avatarDefault_txnyzu.png',
                          password: passwordController.text);
                      newCustomer.listReservations = [];
                      newCustomer.listDiscounts = [];
                      newCustomer.role = [];
                      newCustomer.creationDate = "";
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
                      (fullnameController.text.isNotEmpty) &&
                      (emailController.text.isNotEmpty) &&
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
                          fullName: fullnameController.text,
                          email: emailController.text,
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
                  style: TextStyle(color: Theme.of(context).highlightColor, fontSize: 25),
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
                  color:  Colors.red, 
                  borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () async {
                    isOwner = true;
                    print(isOwner);
                },
                child: Text(translate('owner'),style: const TextStyle(color: Colors.black, fontSize: 25)),
                
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
                child: Text(translate('customer'),style: const TextStyle(color: Colors.black, fontSize: 25)),
                
              ),
            ),
            
          ],
        ),
      ),
    );
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

  void validateEmail(String val) {
    if (val.isEmpty) {
      setState(() {
        _errorMessage = translate('login_page.email_empty');
        buttonEnabled = false;
      });
    } else if (!EmailValidator.validate(val, true)) {
      setState(() {
        _errorMessage = translate('login_page.email_invalid');
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
    values: <int, String> {
      1: translate('language.name.en'),
      2: translate('language.name.es'),
      3: translate('language.name.ca'),
    },
    onChange: (language) {
      if(language == 1) changeLocale(context, 'en');
      if(language == 2) changeLocale(context, 'es');
      if(language == 3) changeLocale(context, 'ca');
    },
  );
}
