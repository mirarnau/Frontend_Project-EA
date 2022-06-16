// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_tutorial/models/restaurant.dart';
import 'package:flutter_tutorial/pages/mainPage.dart';
import 'package:flutter_tutorial/pages/ownerMainPage.dart';

import 'package:flutter_tutorial/pages/profilePage.dart';
import 'package:flutter_tutorial/pages/registerPage.dart';

import 'package:flutter_tutorial/services/customerService.dart';
import 'package:flutter_tutorial/services/loginService.dart';
import 'package:flutter_tutorial/models/customer.dart';
import 'package:flutter_tutorial/models/owner.dart';
import 'package:flutter_tutorial/services/ownerService.dart';
import 'package:flutter_tutorial/services/pdfService.dart';
import 'package:flutter_tutorial/services/restaurantService.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_animations/stateless_animation/mirror_animation.dart';

class InfoOwnerRestaurantPage extends StatefulWidget {
  final Restaurant? selectedRestaurant;
  const InfoOwnerRestaurantPage({Key? key, required this.selectedRestaurant}) : super(key: key);

  @override
  _InfoOwnerRestaurantPageState createState() => _InfoOwnerRestaurantPageState();
}

class _InfoOwnerRestaurantPageState extends State<InfoOwnerRestaurantPage> {
  final RestaurantService _restaurantService = RestaurantService();
  late Restaurant? selectedRest = widget.selectedRestaurant;
  late int _counter = 0;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    super.dispose();
  }

  @override
  void initState() {
    
    super.initState();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MirrorAnimation<double> ( // <-- changed to "MirrorAnimation"
      duration: Duration(milliseconds: 1500),
      curve: Curves.easeInOut,
      tween: Tween(begin: 110.0, end: 250.0),
      builder: (context, child, value) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).cardColor,
          ),
          body: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image(image: NetworkImage(selectedRest!.photos[0])),
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 2.0),
                            child: Text(
                              selectedRest!.restaurantName,
                              style: TextStyle(
                                color: Theme.of(context).highlightColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                              selectedRest!.city,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 50),
                        child: Icon(
                          Icons.people,
                          color: Color.fromARGB(255, value.toInt(), 0, 0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:3.0),
                        child: Text(
                          selectedRest!.occupation.toString(),
                          style: TextStyle(
                            color: Theme.of(context).highlightColor,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 50),
                        child: Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:3.0),
                        child: Text(
                          selectedRest!.rating.toString(),
                          style: TextStyle(
                            color: Theme.of(context).highlightColor,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Text(
                      selectedRest!.description,
                      style: TextStyle(
                        fontStyle: FontStyle.italic
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        translate('info_owner.add'),
                        style: TextStyle(fontSize: 20.0),
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          FloatingActionButton(
                            heroTag: "decrementButton",
                            foregroundColor: Theme.of(context).hoverColor,
                            backgroundColor: Theme.of(context).primaryColor,
                            child: Icon(Icons.remove),
                            onPressed: () {
                              _decrementCounter();
                            },
                          ),
                          SizedBox(width: 40.0),
                          Text(
                            '$_counter',
                            style: TextStyle(fontSize: 25.0),
                          ),
                          SizedBox(width: 40.0),
                          FloatingActionButton(
                            heroTag: "incrementButton",
                            foregroundColor:  Theme.of(context).hoverColor,
                            backgroundColor: Theme.of(context).primaryColor,
                            child: Icon(Icons.add),
                            onPressed: () {
                              _incrementCounter();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Container(
                      width: 150,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: TextButton(
                        child: Text (
                          translate('update'),
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                        onPressed: () async {
                          if (_counter != 0) {
                            if (_counter > 0) {
                              var occupation = selectedRest!.occupation + _counter;
                              List<dynamic> stats = selectedRest!.statsLog;
                              Map newLog;
                              
                              if(DateTime.parse(stats.last['date']).day == DateTime.now().toUtc().day && DateTime.parse(stats.last['date']).month == DateTime.now().toUtc().month && DateTime.parse(stats.last['date']).year == DateTime.now().toUtc().year) {
                                stats.last['occupation'] += _counter;
                              }
                              else {
                                newLog = {
                                  'date': DateTime.now().toUtc().toString(),
                                  'rating': stats.last['rating'],
                                  'occupation': _counter, 
                                };

                                stats.add(newLog);
                              }

                              Restaurant? restaurantUpdate = Restaurant(
                                id: selectedRest!.id, 
                                owner: selectedRest!.owner, 
                                restaurantName: selectedRest!.restaurantName, 
                                email: selectedRest!.email, 
                                address: selectedRest!.address, 
                                description: selectedRest!.description, 
                                city: selectedRest!.city, 
                                photos: selectedRest!.photos, 
                                rating: selectedRest!.rating, 
                                occupation: occupation, 
                                statsLog: stats, 
                                listTags: selectedRest!.listTags, 
                                listDishes: selectedRest!.listDishes, 
                                creationDate: selectedRest!.creationDate, 
                                location: selectedRest!.location
                              );
                              await _restaurantService.updateRestaurant(restaurantUpdate, restaurantUpdate.id);
                              
                              selectedRest = await _restaurantService.getRestaurantByName(restaurantUpdate.restaurantName);

                              _counter = 0;
                            }
                            else {
                              var occupation = selectedRest!.occupation + _counter;

                              Restaurant? restaurantUpdate = Restaurant(
                                id: selectedRest!.id, 
                                owner: selectedRest!.owner, 
                                restaurantName: selectedRest!.restaurantName, 
                                email: selectedRest!.email, 
                                address: selectedRest!.address, 
                                description: selectedRest!.description, 
                                city: selectedRest!.city, 
                                photos: selectedRest!.photos, 
                                rating: selectedRest!.rating, 
                                occupation: occupation, 
                                statsLog: selectedRest!.statsLog, 
                                listTags: selectedRest!.listTags, 
                                listDishes: selectedRest!.listDishes, 
                                creationDate: selectedRest!.creationDate, 
                                location: selectedRest!.location
                              );
                              await _restaurantService.updateRestaurant(restaurantUpdate, restaurantUpdate.id);
                              
                              selectedRest = await _restaurantService.getRestaurantByName(restaurantUpdate.restaurantName);

                              _counter = 0;
                            }
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
