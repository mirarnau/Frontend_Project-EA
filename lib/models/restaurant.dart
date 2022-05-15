import 'package:flutter_tutorial/models/dish.dart';

class Restaurant {
  late final String id;
  late final String owner;
  late final String restaurantName;
  late final String email;
  late final String address;
  late final String description;
  late final String city;
  late final List<dynamic> photos;
  late final int rating;
  late final List<dynamic> listTags;
  late final List<dynamic> listDishes;
  late final String creationDate;


  Restaurant({
    required this.id,
    required this.owner, 
    required this.restaurantName, 
    required this.email, 
    required this.address,
    required this.description,
    required this.city,
    required this.photos,
    required this.rating,
    required this.listTags,
    required this.listDishes,
    required this.creationDate
  });

  factory Restaurant.fromJSON(dynamic json){
    Restaurant restaurant =  Restaurant(
      id: json['_id'] as String,
      owner: json['owner'] as String,
      restaurantName: json['restaurantName'] as String, 
      email: json['email'] as String,
      address: json['address'] as String,
      description: json['description'] as String,
      city: json['city'] as String,
      photos: json['photos'] as List<dynamic>,
      rating: json['rating'] as int,
      listTags: json ['listTags'] as List<dynamic>,
      listDishes: json['listDishes'] as List <dynamic>,
      creationDate: json['creationDate'] as String
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
    var json = {
      'tags': [
        for (var i = 0; i < tags.length; i++){
          'tagName': tags[i]
        }
      ]
    };
    print(json);
    return json;
  }
  
}

class Tag {
    late final String tagName;
}

