import 'dart:ffi';
import 'package:flutter_tutorial/models/dish.dart';

class Restaurant {
  late final String _id;
  late final String owner;
  late final String restaurantName;
  late final String email;
  late final String address;
  late final String description;
  late final List<String> photos;
  late final Double rating;
  late final List<Tag> listTags;
  late final List<Dish> listDishes;
  late final String creationDate;


  Restaurant({
    required this.owner, 
    required this.restaurantName, 
    required this.email, 
    required this.address,
    required this.description,
    required this.photos,
    required this.rating,
    required this.listTags,
    required this.listDishes
  });

  factory Restaurant.fromJSON(dynamic json){
    Restaurant restaurant =  Restaurant(
      owner: json['owner'],
      restaurantName: json['restaurantName'], 
      email: json['email'],
      address: json['address'],
      description: json['description'],
      photos: json['photos'],
      rating: json['rating'],
      listTags: json ['listTags'],
      listDishes: json['listDishes']
      );
      return restaurant;
  }

   static Map<String, dynamic> toJson(Restaurant restaurant) {
    return {
      'owner': restaurant.owner,
      'restaurantName': restaurant.restaurantName,
      'email': restaurant.email,
      'address': restaurant.address,
      'description': restaurant.description,
      'listTags': restaurant.listTags
    };
  }

  static Map<String, dynamic> tagsToJson(List<String> tags) {
    return {
      'tags': [
        for (var i = 0; i < tags.length; i++){
          'tagName': tags[i]
        }
      ]
    };
  }
  
}

class Tag {
    late final String tagName;
}

