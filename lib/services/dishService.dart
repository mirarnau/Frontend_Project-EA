import 'dart:convert';
import 'package:flutter_tutorial/config.dart';
import 'package:flutter_tutorial/models/dish.dart';
import 'package:http/http.dart' as http;

class DishApi{
  var baseUrl = apiURL + "/api/dishes";

  //In Dart, promises are called Future.

  Future<List<Dish>?> getAllDishes() async {
    var res = await http.get(Uri.parse(baseUrl));
    List<Dish> allDishes = [];

    if (res.statusCode == 200){
      var decoded = jsonDecode(res.body);
      decoded.forEach((dish) => allDishes.add(Dish.fromJSON(dish)));
      return allDishes;
    }
    return null;
  }


  /*
   Future <Dish?> addUser(Dish user) async{
    var res = await http.post(Uri.parse(baseUrl),
       headers: {'content-type': 'application/json'},
       body: json.encode(Dish.toJson(user)));

    if (res.statusCode == 201){
      Dish newUser = Dish.fromJSON(res.body);
      return newUser;
    }
    return null;
  }
  */
}

