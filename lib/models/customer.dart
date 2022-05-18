import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

class Customer {
  late final String id;
  late final String customerName;
  late final String fullName;
  late final String email;
  late final String password;
  late final String profilePic;
  late final bool isDarkMode;
  late final String about;

  Customer(
      {required this.customerName,
      required this.fullName,
      required this.email,
      required this.password,
      required this.profilePic});

  factory Customer.fromJSON(dynamic json) {

    Customer customer = Customer(
        customerName: json['customerName'] as String,
        fullName: json['fullName'],
        email: json['email'],
        password: json['password'],
        profilePic:json['profilePic']);
        //profilePic: Image.memory(base64Decode(json['profilePic'])));
    customer.id = json['_id'];
    return customer;
  }

  static Map<String, dynamic> toJson(Customer customer) {
    File imageFile = File("assets/images/userDefaultPic.png");
    List<int> imageBytes = imageFile.readAsBytesSync();
    var pic = base64Encode(imageBytes);
    
    return {
      'customerName': customer.customerName,
      'fullName': customer.fullName,
      'email': customer.email,
      'password': customer.password,
      'profilePic': pic
    };
  }
}
