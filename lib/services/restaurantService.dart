import 'dart:convert';
import 'dart:ffi';
import 'package:flutter_tutorial/models/customer.dart';
import 'package:flutter_tutorial/models/restaurant.dart';
import 'package:http/http.dart' as http;

class RestaurantService{
  var baseUrl = "http://10.0.2.2:3000/api/restaurants";


   Future<List<Restaurant>?> filterRestaurants (List<String> listTags) async {
    var res = await http.post(Uri.parse(baseUrl + '/filters/tags'),
      body: json.encode(Restaurant.tagsToJson(listTags)));

    if (res.statusCode == 404){
      return null;
    }
    List<Restaurant> listFiltered = [];
    for (var i; i < res.body.length ; i++){
      listFiltered[i] = Restaurant.fromJSON(jsonDecode(res.body));
    }
    return listFiltered;
  }
}

