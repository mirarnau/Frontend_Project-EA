import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_tutorial/models/owner.dart';
import 'package:flutter_tutorial/pages/profilePage.dart';
import 'package:flutter_tutorial/services/ownerService.dart';
import 'package:flutter_tutorial/pages/listRestaurantsOwnerPage.dart';

import '../models/customer.dart';
import 'listRestaurantsOwnerPage.dart';
import 'ownerRestaurantsPage.dart';

class OwnerMainPage extends StatefulWidget {
  final Owner? owner;
  late final int selectedIndex;
  final List<String> transferRestaurantTags;
  OwnerMainPage({Key? key, required this.owner, required this.selectedIndex, required this.transferRestaurantTags}) : super(key: key);

  @override
  _OwnerMainPageState createState() => _OwnerMainPageState();
}

class _OwnerMainPageState extends State<OwnerMainPage> {
  int _selectedIndex = 0;
  late final Owner? _owner = widget.owner;
  late final String nameRestaurant = '';

  static const TextStyle optionStyle =
    TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Dashboard',
      style: optionStyle,
    ),
    Text(
      'Index 1: My Restaurants',
      style: optionStyle,
    ),
    //ProfilePage(customer: widget.customer),
    Text(
      'Index 2: Profile',
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
    OwnerRestaurantPage(owner: _owner, nameRestaurant: nameRestaurant),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 65),
            Icon(Icons.menu),
            SizedBox(width: 10),
            Text(translate('main_page'))
          ],
        ),
      ),*/
     body: Center(
        child: screens.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 43, 43, 43),
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: 'Restaurants',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: const Color.fromARGB(255, 101, 101, 101),
        selectedItemColor: Color.fromARGB(255, 213, 94, 85),
        onTap: _onItemTapped,
      ),
    );
  }

  
}
