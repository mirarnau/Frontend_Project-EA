import 'package:flutter/material.dart';
import 'package:flutter_tutorial/models/restaurant.dart';
import 'package:flutter_tutorial/widgets/restaurantWidget.dart';
import 'package:flutter_tutorial/services/restaurantService.dart';

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
    //myTags.add("Vegan");
    //myTags.add("Pets allowed");
    myTags.add("Live music");
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
      return const Scaffold(
        body: Text ('There are no restaurants available',
                  style: TextStyle(
                    fontSize: 20
                  ),
        )
      );
    }
    return Scaffold(
        body: Column (
          mainAxisSize: MainAxisSize.min,
          children: <Widget> [
            SizedBox(
              height: 47,
              child: 
                ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount:  myTags.length,
                  itemBuilder: (context, index){
                    return Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: 
                      Text(
                        myTags[index],
                        style: const TextStyle(
                          color: Colors.white
                        ),
                      ),
                    );
                  }
                )
            ),
            Expanded(
              child: 
              ListView.builder(
                shrinkWrap: true,
                itemCount: listRestaurants?.length,
                itemBuilder: (context, index) {
                  return CardRestaurant(
                      restaurantName: listRestaurants![index].restaurantName,
                      city: listRestaurants![index].city,
                      rating: listRestaurants![index].rating.toString(),
                      imagesUrl: listRestaurants![index].photos);
                }
              )
            )
            
          ],
        )
    );
  }
}
