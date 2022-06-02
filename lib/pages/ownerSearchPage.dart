import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_tutorial/models/restaurant.dart';
import 'package:flutter_tutorial/pages/ownerRestaurantsPage.dart';
import 'package:flutter_tutorial/services/ownerService.dart';
import 'package:flutter_tutorial/widgets/restaurantWidget.dart';
import 'package:flutter_tutorial/services/ownerService.dart';

import '../models/owner.dart';
import '../widgets/restaurantOwnerWidget.dart';
class SearchPage extends StatefulWidget {
  final Owner? owner;
  SearchPage({Key? key, required this.owner}) : super(key: key);
  @override
  _SearchPageState createState() => _SearchPageState();
  final myController = TextEditingController();
}
class _SearchPageState extends State<SearchPage>{
  final myController = TextEditingController();
  late Owner? _owner = widget.owner;
    @override
    void dispose() {
      // Clean up the controller when the widget is disposed.
      myController.dispose();
      super.dispose();
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
          title: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: TextField(
            controller: myController,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  color: Color.fromARGB(255, 0, 0, 0),
                  onPressed: () {
                  },
                ),
                
                hintText: 'Search your restaurants...',
                border: InputBorder.none),
          ),
        ),
      )),
      body: Container(
        padding: EdgeInsets.only(top: 20.0),
        color: Colors.grey,
   
           
      
      )

      
      ,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context)=> OwnerRestaurantPage(owner: _owner, nameRestaurant: myController.text)
          )
          );
          /*
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(myController.text),
              );
            },
          );
          */
        },
        child: const Icon(Icons.search),
    ),
        backgroundColor: Color.fromARGB(255, 102, 100, 100),
    );
  }
}