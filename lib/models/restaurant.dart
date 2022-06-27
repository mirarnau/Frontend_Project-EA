import 'package:flutter_tutorial/models/dish.dart';

class Restaurant {
  late final String id;
  late final String owner;
  late final String restaurantName;
  late final String email;
  late final String phone;
  late final String address;
  late final String description;
  late final String city;
  late final String menuPdf;
  late final List<dynamic> photos;
  late final List<dynamic> rating;
  late final int occupation;
  late final List<dynamic> statsLog;
  late final List<dynamic> listTags;
  late final List<dynamic> listDishes;
  late final String creationDate;
  late final Location location;


  Restaurant({
    required this.id,
    required this.owner, 
    required this.restaurantName, 
    required this.email, 
    required this.phone,
    required this.address,
    required this.description,
    required this.city,
    required this.photos,
    required this.rating,
    required this.occupation,
    required this.statsLog,
    required this.listTags,
    required this.listDishes,
    required this.creationDate,
    required this.location
  });

  factory Restaurant.fromJSON(Map<String, dynamic> json) {
    Restaurant restaurant =  Restaurant(
      id: json['_id'] as String,
      owner: json['owner'] as String,
      restaurantName: json['restaurantName'] as String, 
      email: json['email'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String,
      description: json['description'] as String,
      city: json['city'] as String,
      photos: json['photos'] as List<dynamic>,
      rating: json['rating'] as List<dynamic>,
      occupation: json['occupation'] as int,
      statsLog: json['statsLog'] as List<dynamic>,
      listTags: json ['listTags'] as List<dynamic>,
      listDishes: json['listDishes'] as List <dynamic>,
      creationDate: json['creationDate'] as String,
      location : Location.fromJSON(json['location'])
      );
      restaurant.menuPdf = json['menuPdf'] as String;
      
      return restaurant;
  }


   static Map<String, dynamic> toJson(Restaurant restaurant) {
    return {
      'owner': restaurant.owner,
      'restaurantName': restaurant.restaurantName,
      'email': restaurant.email,
      'phone': restaurant.phone,
      'address': restaurant.address,
      'description': restaurant.description,
      'listTags': restaurant.listTags,
      'occupation': restaurant.occupation,
      'statsLog': restaurant.statsLog,
      'rating': restaurant.rating,
    };
  }

  static Map<String, dynamic> tagsToJson(List<String> tags) {
    var json = {
      'tags': [
        for (var i = 0; i < tags.length; i++){
          'tagName': tags[i]
        }
      ]
    };
    return json;
  }
  
}

class Tag {
    late final String tagName;
}

class Location{
  late final List<double> coordinates;

  Location({
    required this.coordinates
  });

  factory Location.fromJSON(dynamic json){
    var coordinates = json['coordinates'];
    List<double> coordinatesDouble = List<double>.from(coordinates);
    Location location = Location(
      coordinates: coordinatesDouble
    );
    return location;
  }
}

class Stats {
  Stats(this.date, this.rating, this.occupation);

  late final double rating;
  late final double occupation;
  late final DateTime date;
}

