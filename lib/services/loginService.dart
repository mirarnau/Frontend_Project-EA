import 'dart:convert';
import 'package:flutter_tutorial/models/customer.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

class LoginService {
  final LocalStorage storage = LocalStorage('key');
  var baseUrlCustomers = "http://10.0.2.2:3000/api/customers";
  var baseUrlOwners = "http://10.0.2.2:3000/api/owners";

  Future<String?> loginCustomer(String customerName, String password) async {
      final msg = jsonEncode({"customerName": customerName, "password": password});
      var res = await http.post(Uri.parse(baseUrlCustomers + '/login'),
        headers: {'content-type': 'application/json'},
        body: msg
      );
      if (res.statusCode == 200) {
        var token = JWTtoken.fromJson(await jsonDecode(res.body));
        storage.setItem('token', token.toString());
        print (token);
        return "200";
      }
      else {
        return await jsonDecode(res.body);
      }

    }

  Future<String?> loginOwner(String ownerName, String password) async {
    final msg = jsonEncode({"ownerName": ownerName, "password": password});
    var res = await http.post(Uri.parse(baseUrlOwners + '/login'),
      headers: {'content-type': 'application/json'},
      body: msg
    );
    if (res.statusCode == 200) {
      var token = JWTtoken.fromJson(await jsonDecode(res.body));
      storage.setItem('token', token.toString());
      print (token);
      return "200";
    }
    else {
      return await jsonDecode(res.body);
    }

  }
}

class JWTtoken {
  final String tokValue;

  JWTtoken({
    required this.tokValue,
  });

  factory JWTtoken.fromJson(Map<String, dynamic> json) {
    return JWTtoken(
      tokValue: json['token'] as String,
    );
  }
 
  String toString() {
    return tokValue;
  }
}