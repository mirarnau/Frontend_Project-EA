import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_tutorial/models/restaurant.dart';
import 'package:flutter_tutorial/pages/infoOwnerRestaurantPage.dart';
import 'package:flutter_tutorial/pages/statsPage.dart';
import 'package:flutter_tutorial/services/ownerService.dart';
import 'package:flutter_tutorial/services/restaurantService.dart';
import 'package:flutter_tutorial/widgets/restaurantWidget.dart';
import 'package:flutter_tutorial/services/ownerService.dart';

import '../models/owner.dart';
import '../widgets/restaurantOwnerWidget.dart';
import 'infoRestaurantPage.dart';
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
  List<Restaurant>? myRestaurants;
  Restaurant? searchedRestaurant;
  bool isLoading = true;
  List<String> myTags = [];

  

  @override
  void initState() { 
    if (_nameRestaurant != '') { 
      searchRestaurant();
    }
    getRestaurants();
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

    if(_nameRestaurant == '') {
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
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FittedBox(
          child: FloatingActionButton.extended(
            backgroundColor: Theme.of(context).cardColor,
            icon: Icon(
              Icons.local_restaurant_outlined,
              color: Theme.of(context).focusColor),
            label: Text(
              translate('stats_page.title'),
              style: TextStyle(
                color: Theme.of(context).focusColor
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StatsPage(
                    restaurants: myRestaurants,
                    owner: widget.owner,
                  ),
                ),
              );
            },
          ),
        ) ,
        body: Container(
          padding: EdgeInsets.only(top: 20.0),
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
                  return GestureDetector(
                    child: CardRestaurant(
                      restaurantName: myRestaurants![index].restaurantName,
                      city: myRestaurants![index].city,
                      rating: myRestaurants![index].rating.toString(),
                      imagesUrl: myRestaurants![index].photos,
                      occupation: myRestaurants![index].occupation,
                      address: myRestaurants![index].address),
                    onTap: () {
                      var routes = MaterialPageRoute(
                        builder: (BuildContext context) => 
                          InfoOwnerRestaurantPage(selectedRestaurant: myRestaurants?[index],)
                      );
                      Navigator.of(context).push(routes);
                    },);
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FittedBox(
        child: FloatingActionButton.extended(
          backgroundColor: Theme.of(context).cardColor,
          icon: Icon(
            Icons.local_restaurant_outlined,
            color: Theme.of(context).focusColor),
          label: Text(
            translate('help'),
            style: TextStyle(
              color: Theme.of(context).focusColor
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StatsPage(
                  restaurants: myRestaurants,
                  owner: widget.owner,
                ),
              ),
            );
          },
        ),
      ) ,
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
                    return GestureDetector(
                      child: CardRestaurant(
                        restaurantName: myRestaurants![index].restaurantName,
                        city: myRestaurants![index].city,
                        rating: myRestaurants![index].rating.toString(),
                        imagesUrl: myRestaurants![index].photos,
                        occupation: myRestaurants![index].occupation,
                        address: myRestaurants![index].address),
                      onTap: () {
                        var routes = MaterialPageRoute(
                          builder: (BuildContext context) => 
                            InfoOwnerRestaurantPage(selectedRestaurant: myRestaurants?[index],)
                        );
                        Navigator.of(context).push(routes);
                      },
                    );
                  }
                ),
              ),
              Container(
                child: TextButton(  
                child: Text(translate('done')),  
                onPressed: ()  {}
                ),
              ),
            ],
          ),
        )
      );
    }

  } 

    Future<void> getRestaurants() async {
      Owner? owner = this._owner;
      myRestaurants = await restaurantService.filterRestaurants(myTags);
      for (Restaurant restaurant in myRestaurants!) {
        if (restaurant.owner != this._owner!.id) {
          myRestaurants!.remove(restaurant);
        }
      }

      print(myRestaurants![0]);

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

