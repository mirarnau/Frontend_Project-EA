class Restaurant {
  late final String _id;
  late final String restaurantName;
  late final String email;
  late final String description;

  Restaurant(
      {required this.restaurantName,
      required this.email,
      required this.description});

  factory Restaurant.fromJSON(dynamic json) {
    Restaurant restaurant = Restaurant(
        restaurantName: json['restaurantName'],
        email: json['email'],
        description: json['description']);
    restaurant._id = json['_id'];
    return restaurant;
  }

  static Map<String, dynamic> toJson(Restaurant restaurant) {
    return {
      'restaurantName': restaurant.restaurantName,
      'email': restaurant.email,
      'description': restaurant.description,
    };
  }
}
