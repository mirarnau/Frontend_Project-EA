// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
import 'package:flutter_tutorial/widgets/mapWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InfoRestaurantPage extends StatefulWidget {
  final Restaurant? selectedRestaurant;
  const InfoRestaurantPage({Key? key, required this.selectedRestaurant}) : super(key: key);

  @override
  _InfoRestaurantPageState createState() => _InfoRestaurantPageState();
}

class _InfoRestaurantPageState extends State<InfoRestaurantPage> {
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    super.dispose();
  }

  @override
  void initState() {
    print(widget.selectedRestaurant!.location.coordinates[1]);
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image(image: NetworkImage(widget.selectedRestaurant!.photos[0])),
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 2.0),
                    child: Text(
                      widget.selectedRestaurant!.restaurantName,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      widget.selectedRestaurant!.city,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 2.0),
                child: Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:3.0),
                child: Text(
                  widget.selectedRestaurant!.rating.toString(),
                  style: TextStyle(
                    color: Color.fromARGB(255, 44, 44, 44),
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 25.0, 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    border: Border.all(
                      color: Color.fromARGB(255, 213, 94, 85),
                    )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.call,
                      color: Color.fromARGB(255, 213, 94, 85),
                    ),
                  ),
                ),
              )
              
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Text(
              widget.selectedRestaurant!.description,
              style: TextStyle(
                fontStyle: FontStyle.italic
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Container(
              width: 150,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 213, 94, 85),
                borderRadius: BorderRadius.circular(20)

              ),
              child: TextButton(
                onPressed: () {},
                child: Text (
                  "Make reservation",
                  style: TextStyle(
                    color: Colors.white
                  ),
                )
              ),
            ),
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              color: Colors.blue,
              child: MapWidget(
              longRestaurant: widget.selectedRestaurant!.location.coordinates[0], 
              latRestaurant: widget.selectedRestaurant!.location.coordinates[1]
              ),
            ),
        ],
        
      ),
        ],
      )
      
    );
    
  }

  
}
