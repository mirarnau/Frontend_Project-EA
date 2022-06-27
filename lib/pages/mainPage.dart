// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_tutorial/models/customer.dart';

import 'package:flutter_tutorial/pages/listRestaurantsPage.dart';
import 'package:flutter_tutorial/pages/profilePage.dart';
import 'package:flutter_tutorial/pages/reservationPage.dart';
import 'package:flutter_tutorial/pages/ticketsPage.dart';
import 'package:flutter_tutorial/pages/wallPage.dart';
import 'package:flutter_tutorial/pages/wallPageCustomer.dart';
import 'package:flutter_tutorial/pages/indexPage.dart';

class MainPage extends StatefulWidget {
  final Customer? customer;
  late final int selectedIndex;
  late final String chatPage;
  late final double maxDistance;
  late final String filterType;
  final List<String> transferRestaurantTags;
  MainPage(
      {Key? key,
      required this.customer,
      required this.selectedIndex,
      required this.transferRestaurantTags,
      required this.maxDistance,
      required this.filterType,
      required this.chatPage})
      : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final Customer? _customer = widget.customer;
  late int _selectedIndex = widget.selectedIndex;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 1: Restaurants',
      style: optionStyle,
    ),
    Text(
      'Index 2: Agenda',
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
    ListRestaurantsPage(newTags: widget.transferRestaurantTags, customer: _customer, maxDistance: widget.maxDistance, filterType: widget.filterType,),
    TicketsPage(userType: "Customer", myName: widget.customer!.customerName, page: widget.chatPage, user: widget.customer,),
    WallPage(customer: widget.customer!),
    ReservationPage(myCustomer: widget.customer!, myName: widget.customer!.customerName, userType: "Customer"), //
    ProfilePage(customer: _customer),
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
            icon: Icon(Icons.photo_camera),
            label: 'Posts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_agenda_rounded),
            label: translate('nav_bar.agenda'),
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
