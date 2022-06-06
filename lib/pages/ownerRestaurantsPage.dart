import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_tutorial/models/restaurant.dart';
import 'package:flutter_tutorial/services/ownerService.dart';
import 'package:flutter_tutorial/services/restaurantService.dart';
import 'package:flutter_tutorial/widgets/restaurantWidget.dart';
import 'package:flutter_tutorial/services/ownerService.dart';

import '../models/owner.dart';
import '../widgets/restaurantOwnerWidget.dart';
import 'ownerSearchPage.dart';

class OwnerRestaurantPage extends StatefulWidget {
    final Owner? owner;
    final String? nameRestaurant;

  const OwnerRestaurantPage({Key? key,  required this.owner, required this.nameRestaurant}) : super(key: key);

  @override
  State<OwnerRestaurantPage> createState() => _OwnerRestaurnats();
}

class _OwnerRestaurnats extends State<OwnerRestaurantPage> {
  late Owner? _owner = widget.owner; 
  late String? _nameRestaurant = widget.nameRestaurant;
  OwnerService ownerService = OwnerService();
  RestaurantService restaurantService = RestaurantService();
  List<dynamic>? myRestaurants;
  Restaurant? searchedRestaurant;
  bool isLoading = true;

  

  @override
  void initState() { 
    if (_nameRestaurant != '') {searchRestaurant();}
    getRestaurants();  
    //getRestaurantIDs(myRestaurants!);
    super.initState();
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
    if(_nameRestaurant == ''){
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text ("SEARCH A RESTAURANT"),
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
          actions: [
            // Navigate to the Search Screen
            IconButton(
                onPressed: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => SearchPage(owner: _owner,))),
                icon: Icon(Icons.search))
          ],
        ),
        body: Container(
          padding: EdgeInsets.only(top: 50.0),
          color: Color.fromARGB(255, 30, 30, 30),
          child: Column (
              mainAxisSize: MainAxisSize.min,
              children: <Widget> [
                Expanded(
                  child: 
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: myRestaurants?.length,
                    itemBuilder: (context, index) {
                      return OwnerCardRestaurant(
                          restaurantName: myRestaurants![index].restaurantName,
                          city: myRestaurants![index].city,
                          rating: myRestaurants![index].rating.toString(),
                          address: myRestaurants![index].address,
                          imagesUrl: myRestaurants![index].photos,);
                    }
                  )
                )
                
              ],
            ),
        )
          );                
    }
    else{
      return Scaffold(
      body: Container(
          padding: EdgeInsets.only(top: 50.0),
          color: Color.fromARGB(255, 30, 30, 30),
          child: Column (
              mainAxisSize: MainAxisSize.min,
              children: <Widget> [
                Expanded(
                  child: 
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return OwnerCardRestaurant(
                          restaurantName: searchedRestaurant!.restaurantName,
                          city: searchedRestaurant!.city,
                          rating: searchedRestaurant!.rating.toString(),
                          address: searchedRestaurant!.address,
                          imagesUrl: searchedRestaurant!.photos,);
                    }
                  )
                )
                
              ],
            ),
        )
      );
          }

  } 

    Future<void> getRestaurants() async {
      Owner? owner = this._owner;
      myRestaurants = await ownerService.getOwnerById(owner!) ;
      //print(myRestaurants);
      setState(() {
        isLoading = false;
      });
    }

    Future<void> searchRestaurant() async {
      String? rest = this._nameRestaurant;
      print(rest);
      searchedRestaurant = await restaurantService.getRestaurantByName(rest!);
      print (searchedRestaurant);
    }
    
  }

