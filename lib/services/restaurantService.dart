import 'dart:convert';
import 'package:flutter_tutorial/models/restaurant.dart';
import 'package:http/http.dart' as http;

class DishApi {
  var baseUrl = "http://10.0.2.2:3000/api/restaurants";

  //In Dart, promises are called Future.

  Future<List<Restaurant>?> getAllRestaurants() async {
    var res = await http.get(Uri.parse(baseUrl));
    List<Restaurant> allRestaurants = [];

    if (res.statusCode == 200) {
      var decoded = jsonDecode(res.body);
      decoded.forEach(
          (restaurant) => allRestaurants.add(Restaurant.fromJSON(restaurant)));
      return allRestaurants;
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
