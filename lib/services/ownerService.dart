import 'dart:convert';
import 'package:flutter_tutorial/config.dart';
import 'package:flutter_tutorial/models/owner.dart';
import 'package:flutter_tutorial/models/restaurant.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

class OwnerService {
  var baseUrl = apiURL + "/api/owners";

  //In Dart, promises are called Future.

  Future<Owner?> getOwnerByName(String ownerName) async {
    var res = await http.get(Uri.parse(baseUrl + '/name/' + ownerName),
      headers: {'authorization': LocalStorage('key').getItem('token')});
    if (res.statusCode == 200) {
      Owner owner = Owner.fromJSON(jsonDecode(res.body));
      return owner;
    }
    return null;
  }

  Future<List<dynamic>?> getOwnerById(Owner owner) async {
    String id = owner.id;
    var res = await http.get(Uri.parse(baseUrl + '/' + id),
      headers: {'authorization': LocalStorage('key').getItem('token')});
    if (res.statusCode == 200) {
      var listRestaurants = owner.restaurants;
      return listRestaurants;
    }
    return null;
    }

  Future<Owner?> update(Owner owner, String id) async {
    var res = await http.put(Uri.parse(baseUrl + '/' + id),
        headers: {'content-type': 'application/json'},
        body: json.encode(Owner.toJson(owner)));

    if (res.statusCode == 201) {
      Owner newOwner = Owner.fromJSON(res.body);
      return newOwner;
    }
    return null;
  }

  Future<List<Owner>?> getAllOwners() async {
    var res = await http.get(Uri.parse(baseUrl));

    List<Owner> allOwners = [];
    if (res.statusCode == 200) {
      var decoded = jsonDecode(res.body);
      decoded
          .forEach((owner) => allOwners
    .add(Owner.fromJSON(owner)));
      return allOwners;
    }

    return null;
  }

  Future<Owner?> addOwner(Owner owner) async {
    var res = await http.post(Uri.parse(baseUrl),
        headers: {'content-type': 'application/json'},
        body: json.encode(Owner.toJson(owner)));

    if (res.statusCode == 201) {
      Owner newOwner = Owner.fromJSON(res.body);
      return newOwner;
    }
    return null;
  }

  Future<bool> deleteOwner(String _id) async {
    var res = await http.delete(Uri.parse(baseUrl + '/' + _id));
    int statusCode = res.statusCode;
    if (statusCode == 200) return true;
    return false;
  }
}
