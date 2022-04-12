import 'dart:convert';
import 'package:flutter_tutorial/models/user.dart';
import 'package:http/http.dart' as http;

class UserService{
  var baseUrl = "http://10.0.2.2:3000/api/users";

  //In Dart, promises are called Future.

  Future<List<User>?> getAllUsers() async {
    var res = await http.get(Uri.parse(baseUrl));

    List<User> allUsers = [];
    if (res.statusCode == 200){
      var decoded = jsonDecode(res.body);
      decoded.forEach((customer) => allUsers.add(User.fromJSON(customer)));
      return allUsers;
    }

    return null;
  }

  Future <User?> addUser(User user) async{
    var res = await http.post(Uri.parse(baseUrl),
       headers: {'content-type': 'application/json'},
       body: json.encode(User.toJson(user)));

    if (res.statusCode == 201){
      User newUser = User.fromJSON(res.body);
      return newUser;
    }
    return null;
  }

  Future<bool> deleteUser(String name) async {
    var res = await http.delete(Uri.parse(baseUrl + '/' + name));
    int statusCode = res.statusCode;
    if (statusCode == 200) return true;
    return false;
  }
  
}
