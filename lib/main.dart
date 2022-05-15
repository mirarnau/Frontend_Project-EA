import 'package:flutter/material.dart';
import 'package:flutter_tutorial/pages/loginPage.dart';

void main() {
  runApp(const MyApp());
}

//MyApp is the root widget
class MyApp extends StatelessWidget {
  //The fact that it's a statless widget ENABLES HOT RELOAD
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //MaterialApp is another widget, and it allows us to make the designs, it acts as a wrapper for the other widgets.
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
