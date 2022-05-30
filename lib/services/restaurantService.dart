import 'dart:convert';
import 'package:flutter_tutorial/config.dart';
import 'package:flutter_tutorial/models/restaurant.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

class RestaurantService{
  var baseUrl = apiURL + "/api/restaurants";


   Future<List<Restaurant>?> filterRestaurants (List<String> listTags) async {
    var res = await http.post(Uri.parse(baseUrl + '/filters/tags'),
      headers: {'content-type': 'application/json', 'authorization': LocalStorage('key').getItem('token')},
      body: json.encode(Restaurant.tagsToJson(listTags)));

    if (res.statusCode == 404){
      return null;
    }

    List<Restaurant> listFiltered = [];
    var decoded = jsonDecode(res.body);
    decoded.forEach((restaurant) => listFiltered.add(Restaurant.fromJSON(restaurant)));
    
    print (listFiltered[0].location.coordinates[0]);
    return listFiltered;
  }
}

