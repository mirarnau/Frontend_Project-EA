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
                      (passwordController.text.isNotEmpty) && (isOwner == false)) {
                    setState(() {
                      buttonEnabled = true;
                    });
                    var res = await loginService.loginCustomer(
                        customernameController.text, passwordController.text);
                    if (res == "401") {
                      showAlertDialog(context);
                      return;
                    }
                    
                    List<String> voidListTags = [];

                    Customer? customer = await customerService.getCustomerByName(customernameController.text);

                    var route = MaterialPageRoute(
                      builder: (BuildContext context) =>
                          MainPage(customer: customer, selectedIndex: 1, transferRestaurantTags: voidListTags,));

        

                    if (customer == null){
                      showAlertDialog(context);
                      return null;
                    }
                    
                    Navigator.of(context).push(route);
                    
                   

                    /*
                    save_data(customer.fullName, customer.email,
                        customer.customerName);
                    var route = MaterialPageRoute(
                      builder: (BuildContext context) => ProfilePage(
                          fullName: customer.fullName,
                          email: customer.email,
                          customerName: customer.customerName),
                    );
                    Navigator.of(context).push(route);*/
                  }
                  if ((customernameController.text.isNotEmpty) &&
                      (passwordController.text.isNotEmpty) && (isOwner == true)){
                        setState(() {
                      buttonEnabled = true;
                    });
                    var res = await loginService.loginOwner(
                        customernameController.text, passwordController.text);
                    if (res == "401") {
                      showAlertDialog(context);
                      return;
                    }
                    Owner? owner = await ownerService.getOwnerByName(customernameController.text);
                    if (owner == null){
                      showAlertDialog(context);
                      return null;
                    }
                    var routes = MaterialPageRoute(
                      builder: (BuildContext context) => 
                        OwnerMainPage(owner: owner)
                    );
                    Navigator.of(context).push(routes);
                        

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
              padding: const EdgeInsets.only(bottom: 10),
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
              
          ],
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
            customer: customer,),
      );
      Navigator.of(context).push(route);
    }
  }
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigate();
  }
  

  
  
}
