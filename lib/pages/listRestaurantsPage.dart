import 'package:flutter/material.dart';
import 'package:flutter_tutorial/models/restaurant.dart';
import 'package:flutter_tutorial/services/restaurantService.dart';
import 'package:flutter_tutorial/models/dish.dart';
import 'package:flutter_tutorial/widgets/restaurantWidget.dart';

class ListRestaurantsPage extends StatefulWidget {
  const ListRestaurantsPage({Key? key}) : super(key: key);

  @override
  State<ListRestaurantsPage> createState() => _RestaurantsPageState();
}

class _RestaurantsPageState extends State<ListRestaurantsPage> {
  RestaurantService restaurantService = RestaurantService();
  List<Restaurant>? listRestaurants;
  bool isLoading = true;

  List<String> myTags = [];

  @override
  void initState() {
    super.initState();
    filterDishes();
  }

  Future<void> filterDishes() async {
    listRestaurants = await restaurantService.filterRestaurants(myTags);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (listRestaurants == null){
      return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              SizedBox(width: 65),
              Icon(Icons.restaurant_menu),
              SizedBox(
                  width:
                      10), 
              Text('Restaurants') 
            ],
          ),
        ),
        body: const Text ('There are no restaurants available',
                  style: TextStyle(
                    fontSize: 20
                  ),
        )
      );
    }
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              SizedBox(width: 65),
              Icon(Icons.restaurant_menu), 
              SizedBox(
                  width:
                      10), 
              Text('Restaurants') 
            ],
          ),
        ),
        body: ListView.builder(
            itemCount: listRestaurants?.length,
            itemBuilder: (context, index) {
              return CardRestaurant(
                  restaurantName: listRestaurants![index].restaurantName,
                  address: listRestaurants![index].address,
                  description: listRestaurants![index].description,
                  rating: listRestaurants![index].rating.toString(),
                  imagesUrl: listRestaurants![index].photos);
            }));
  }
}
