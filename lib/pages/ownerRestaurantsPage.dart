import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_tutorial/models/restaurant.dart';
import 'package:flutter_tutorial/services/ownerService.dart';
import 'package:flutter_tutorial/widgets/restaurantWidget.dart';
import 'package:flutter_tutorial/services/ownerService.dart';

import '../models/owner.dart';

class OwnerRestaurantPage extends StatefulWidget {
    final Owner owner;

  const OwnerRestaurantPage({Key? key,  required this.owner}) : super(key: key);

  @override
  State<OwnerRestaurantPage> createState() => _OwnerRestaurnats();
}

class _OwnerRestaurnats extends State<OwnerRestaurantPage> {
  late Owner _owner = widget.owner; 
  OwnerService ownerService = OwnerService();
  List<dynamic>? myRestaurants;
  bool isLoading = true;

  

  @override
  void initState() {   
    super.initState();
  }

  Future<void> filterDishes() async {
    Owner owner = this._owner;
    myRestaurants = await ownerService.getOwnerById(owner);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (myRestaurants == null){
      return Scaffold(
        body: Text (translate('restaurants_page.no_rest'),
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
            Expanded(
              child: 
              ListView.builder(
                shrinkWrap: true,
                itemCount: myRestaurants?.length,
                itemBuilder: (context, index) {
                  return CardRestaurant(
                      restaurantName: myRestaurants![index].restaurantName,
                      city: myRestaurants![index].city,
                      rating: myRestaurants![index].rating.toString(),
                      imagesUrl: myRestaurants![index].photos);
                }
              )
            )
            
          ],
        )
    );
  }
}
