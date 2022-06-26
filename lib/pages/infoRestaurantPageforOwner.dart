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
import 'package:flutter_tutorial/widgets/mapWidget.dart';
import 'package:flutter_tutorial/widgets/ratingWidget.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_animations/stateless_animation/mirror_animation.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class InfoRestaurantPageForOwner extends StatefulWidget {
  final Restaurant? selectedRestaurant;
  const InfoRestaurantPageForOwner({ Key? key, required this.selectedRestaurant }) : super(key: key);

  @override
  _InfoRestaurantPageForOwnerState createState() => _InfoRestaurantPageForOwnerState();
}

class _InfoRestaurantPageForOwnerState extends State<InfoRestaurantPageForOwner> {

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
                                color: Theme.of(context).highlightColor,
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
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Icon(
                          Icons.people,
                          color: Color.fromARGB(255, value.toInt(), 0, 0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:3.0),
                        child: Text(
                          widget.selectedRestaurant!.occupation.toString(),
                          style: TextStyle(
                            color: Theme.of(context).highlightColor,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 3.0),
                        child: Text(
                          widget.selectedRestaurant!.rating.last['rating'].toDouble().toStringAsFixed(1),
                          style: TextStyle(
                            color: Theme.of(context).highlightColor,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
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
                    padding: const EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 400,
                      color: Colors.blue,
                      child: MapWidget(
                      longRestaurant: widget.selectedRestaurant!.location.coordinates[0], 
                      latRestaurant: widget.selectedRestaurant!.location.coordinates[1]
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  

  AlertDialog alert = AlertDialog(
      title: Text(
        "Empty fields",
        style: TextStyle(color: Colors.red),
      ),
      content: Text('Some fields are empty, please fill them'),
      actions: [
        okButton,
      ],
    );
  }
}
