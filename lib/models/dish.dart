

class Dish{
  final String title;
  final double rating;
  final double price;
  final String imageUrl;

  Dish({required this.title, required this.rating, required this.price, required this.imageUrl});

  factory Dish.fromJSON(dynamic json){
    return Dish(
      title: json['title'],
      rating: json['rating'], 
      price: json['price'],
      imageUrl: json['imageUrl']
      );
  }


  //Just to customize the print to parse the JSON correctly in an inteligible format.
  @override
  String toString(){
    return 'Dish {title: $title, price: $price, rating: $rating, imageUrl: $imageUrl }';
  }

}