import 'package:flutter/material.dart';
import 'package:flutter_tutorial/models/restaurant.dart';
import 'package:flutter_tutorial/services/ownerService.dart';
import 'package:flutter_tutorial/widgets/restaurantWidget.dart';
import 'package:flutter_tutorial/services/ownerService.dart';

import '../models/owner.dart';

class OwnerRestaurantPage extends StatefulWidget {
    final Owner? owner;

  const OwnerRestaurantPage({Key? key,  required this.owner}) : super(key: key);

  @override
  State<OwnerRestaurantPage> createState() => _OwnerRestaurnats();
}

class _OwnerRestaurnats extends State<OwnerRestaurantPage> {
  late Owner? _owner = widget.owner; 
  OwnerService ownerService = OwnerService();
  List<dynamic>? myRestaurants;
  bool isLoading = true;

  

  @override
  void initState() { 
    getRestaurants();  
    //getRestaurantIDs(myRestaurants!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (myRestaurants == null){
      return const Scaffold(
        body: Text ('This user has no restaurants',
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
/*
  Future<void> getRestaurantIDs(List<dynamic> list) async {
    for (var _id in list) {
        list.add(_id);
    }

  }
  */

  Future<void> getRestaurants() async {
    Owner? owner = this._owner;
    myRestaurants = await ownerService.getOwnerById(owner!) ;
    print(myRestaurants);
    setState(() {
      isLoading = false;
    });
  }
  
}
