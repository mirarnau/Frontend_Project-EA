// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_tutorial/models/owner.dart';
import 'package:flutter_tutorial/pages/ownerProfilePage.dart';
import 'package:flutter_tutorial/pages/profilePage.dart';
import 'package:flutter_tutorial/pages/ticketsPage.dart';
import 'package:flutter_tutorial/pages/wallPageOwner.dart';
import 'package:flutter_tutorial/services/ownerService.dart';
import 'package:flutter_tutorial/pages/listRestaurantsOwnerPage.dart';
import 'package:meta/meta.dart';
import 'package:flutter_tutorial/pages/indexPage.dart';
import '../models/customer.dart';
import 'listRestaurantsOwnerPage.dart';
import 'ownerRestaurantsPage.dart';
import 'ownerTicketsPage.dart';

class OwnerMainPage extends StatefulWidget {
  final Owner? owner;
  late final int selectedIndex;
  late final String chatPage;
  final List<String> transferRestaurantTags;
  OwnerMainPage(
      {Key? key,
      required this.owner,
      required this.selectedIndex,
      required this.transferRestaurantTags,
      required this.chatPage})
      : super(key: key);

  @override
  _OwnerMainPageState createState() => _OwnerMainPageState();
}

class _OwnerMainPageState extends State<OwnerMainPage> {
  late int _selectedIndex = widget.selectedIndex;
  late final Owner? _owner = widget.owner;
  late final String nameRestaurant = '';

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 1: Dashboard',
      style: optionStyle,
    ),
    Text(
      'Index 2: My Restaurants',
      style: optionStyle,
    ),
     Text(
      'Index 3: Chat',
      style: optionStyle,
    ),
    Text(
      'Index 4: Profile',
      style: optionStyle,
    )
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late final screens = [
    ListRestaurantsOwnerPage(newTags: widget.transferRestaurantTags, owner: _owner),
    TicketsPage(userType: "Owner", myName: widget.owner!.ownerName, page: widget.chatPage, user: widget.owner,),
    OwnerRestaurantPage(owner: _owner, nameRestaurant: nameRestaurant),
    WallPageOwner(owner: widget.owner),
    OwnerProfilePage(owner: _owner)
  ];

  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;
    changeLocale(context, localizationDelegate.currentLocale.languageCode);

    return Scaffold(
      body: Center(
        child: screens.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: translate('nav_bar.restaurants'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            label: translate('nav_bar.chat'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.house),
            label: translate('nav_bar.home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_camera),
            label: 'Posts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: translate('nav_bar.profile'),
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Theme.of(context).shadowColor,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
