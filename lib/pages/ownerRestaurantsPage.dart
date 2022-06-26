// ignore_for_file: prefer_const_constructors

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
import '../widgets/loadingCardsWidget.dart';
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
  List<Restaurant>? myRestaurants = [];
  Restaurant? searchedRestaurant;
  bool _isLoading = true;
  bool _isEmpty = true;
  List<String> myTags = [];

  

  @override
  void initState() { 
    Future.delayed(const Duration(seconds: 1), () {
      getRestaurants();
    });

    if (_nameRestaurant != '') { 
        searchRestaurant();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(_nameRestaurant == '') {
      return Scaffold(
        appBar:
        AppBar(
          automaticallyImplyLeading: false,
          title: Text(translate("restaurants_page.search")),
          backgroundColor: Theme.of(context).cardColor,
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
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column (
            mainAxisSize: MainAxisSize.min,
            children: <Widget> [
              _isLoading 
              ? Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => const LoadingCards(),
                    itemCount: 4
                  ),
                )
              : _isEmpty 
                ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      translate('restaurants_page.no_rest'),
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).highlightColor
                      ),
                    ),
                  ] 
                )
                : Expanded(
                  child: 
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: myRestaurants?.length,
                    itemBuilder: (context, index) {
                    return GestureDetector(
                      child: CardRestaurant(
                        restaurantName: myRestaurants![index].restaurantName,
                        city: myRestaurants![index].city,
                        rating: myRestaurants![index].rating.last['rating'].toDouble().toStringAsFixed(1),
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

    else {
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
      ),
      body: Container(
          padding: EdgeInsets.only(top: 50.0),
          color: Theme.of(context).scaffoldBackgroundColor,
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
                        rating: myRestaurants![index].rating.last['rating'].toDouble().toStringAsFixed(1),
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
              TextButton(  
                child: Text(translate('done')),  
                onPressed: ()  {}
              ),
            ],
          ),
        )
      );
    }

  } 

    Future<void> getRestaurants() async {
      
      setState(() => _isLoading = true);

      List<Restaurant>? rests = await restaurantService.filterRestaurants(myTags);

      for (Restaurant restaurant in rests!) {
        if (restaurant.owner == _owner!.id) {
          myRestaurants!.add(restaurant);
        }
      }

      if(myRestaurants!.isEmpty) {
        _isEmpty = true;
      }
      else {
        _isEmpty = false;
      }

      setState(() => _isLoading = false);

    }

    Future<void> searchRestaurant() async {
      String? rest = _nameRestaurant;
      searchedRestaurant = await restaurantService.getRestaurantByName(rest!);
    }
    
  }

