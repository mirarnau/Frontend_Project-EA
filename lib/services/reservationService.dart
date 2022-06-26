import 'dart:convert';
import 'package:flutter_tutorial/config.dart';
import 'package:flutter_tutorial/models/reservation.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

class ReservationApi {
  var baseUrl = apiURL + "/api/reservations";

  Future<List<Reservation>> getAllReservations() async {
    var res = await http.get(Uri.parse(baseUrl),
        headers: {'authorization': LocalStorage('key').getItem('token')});
    List<Reservation> allReservations = [];
    if (res.statusCode == 200) {
      var decoded = jsonDecode(res.body);
      decoded.forEach((reservation) =>
          allReservations.add(Reservation.fromJSON(reservation)));
      return allReservations;
    }
    return allReservations;
  }

  Future<List<Reservation>?> getReservationById(String id) async {
    var res = await http.get(Uri.parse(baseUrl + '/' + id),
        headers: {'authorization': LocalStorage('key').getItem('token')});
    List<Reservation> myReservations = [];

    if (res.statusCode == 200) {
      var decoded = jsonDecode(res.body);
      decoded.forEach((reservation) =>
          myReservations.add(Reservation.fromJSON(reservation)));
      return myReservations;
    }
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
