// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_tutorial/models/restaurant.dart';
import 'package:flutter_tutorial/models/owner.dart';
import 'package:flutter_tutorial/pages/infoRestaurantPageforOwner.dart';
import 'package:flutter_tutorial/pages/statsPage.dart';
import 'package:flutter_tutorial/widgets/loadingCardsWidget.dart';
import 'package:flutter_tutorial/widgets/restaurantWidget.dart';
import 'package:flutter_tutorial/widgets/lateralRestaurantOwnerWidget.dart';
import 'package:flutter_tutorial/services/restaurantService.dart';

import 'infoRestaurantPage.dart';
import 'mainPage.dart';
import 'ownerMainPage.dart';

class ListRestaurantsOwnerPage extends StatefulWidget {
  final List<String> newTags;
  final Owner? owner;
  const ListRestaurantsOwnerPage({Key? key, required this.newTags, required this.owner}) : super(key: key);

  @override
  State<ListRestaurantsOwnerPage> createState() => _RestaurantsOwnerPageState();
}

class _RestaurantsOwnerPageState extends State<ListRestaurantsOwnerPage> {
  RestaurantService restaurantService = RestaurantService();
  List<Restaurant>? listRestaurants;
  bool _isLoading = true;
  bool _isEmpty = true;


  List<String> myTags = [];

  @override
  void initState() {
    if (widget.newTags.length != 0){
      for (var i = 0; i < widget.newTags.length; i++){
        myTags.add(widget.newTags[i]);
      }
    }

    Future.delayed(const Duration(seconds: 1), () {
      filterDishes();
    });

    super.initState();
  }

  Future<void> filterDishes() async {

    setState(() => _isLoading = true);

    listRestaurants = await restaurantService.filterRestaurants(myTags);

    if(listRestaurants == null) {
      _isEmpty = true;
    } 
    else {
      _isEmpty = false;
    }
    
    setState(() => _isLoading = false);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        title: Text (translate('restaurants_page.filter')),
      ),
      drawer: NavDrawer(owner: widget.owner, previousTags: widget.newTags),
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column (
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
                    padding: const EdgeInsets.fromLTRB(10, 1.5, 0, 2),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 149, 67, 63),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: 
                      Row(
                      children: 
                      [
                        Text(
                            myTags[index],
                            style: const TextStyle(
                            color: Colors.white),
                        ),
                        IconButton(
                          iconSize: 25,
                          color: Color.fromARGB(255, 234, 233, 233),
                          padding: const EdgeInsets.fromLTRB(0, 0, 1, 0),
                          alignment: Alignment.centerRight,
                          onPressed: () {
                            print(myTags[index]);
                            myTags.remove(myTags[index]);
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context)=> OwnerMainPage(owner: widget.owner, selectedIndex: 0, transferRestaurantTags: myTags, chatPage: "Inbox",))
                            );
                          },
                          icon: const Icon(Icons.cancel)
                        )
                      ],
                    )
                  );
                }
              )
            ),
            _isLoading
            ? Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) => const LoadingCards(),
                itemCount: 4
              ),
            )
            : _isEmpty 
              ? Text(
                  translate('restaurants_page.no_match'),
                  style: TextStyle(
                    color: Theme.of(context).highlightColor
                  ),
                )
              : Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: listRestaurants?.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: CardRestaurant(
                        restaurantName: listRestaurants![index].restaurantName,
                        city: listRestaurants![index].city,
                        rating: listRestaurants![index].rating.last['rating'].toDouble().toStringAsFixed(1),
                        imagesUrl: listRestaurants![index].photos,
                        occupation: listRestaurants![index].occupation,
                        address: listRestaurants![index].address),
                      onTap: () {
                        var routes = MaterialPageRoute(
                          builder: (BuildContext context) => 
                            InfoRestaurantPageForOwner(
                              selectedRestaurant: listRestaurants?[index],
                            ),                     
                        );
                        Navigator.of(context).push(routes);
                      },
                    );
                  }
                ),
              ),
          ],
        ),
      ),   
    );
  }
}
