import 'package:flutter/material.dart';
import 'package:flutter_tutorial/models/owner.dart';
import 'package:flutter_tutorial/pages/listRestaurantsPage.dart';
import 'package:flutter_tutorial/pages/profilePage.dart';
import 'package:flutter_tutorial/services/ownerService.dart';

class OwnerMainPage extends StatefulWidget {
  final Owner owner;
  
  OwnerMainPage({Key? key, required this.owner}) : super(key: key);

  @override
  _OwnerMainPageState createState() => _OwnerMainPageState();
}

class _OwnerMainPageState extends State<OwnerMainPage> {
  int _selectedIndex = 0;
  late Owner _owner = widget.owner;

  List<String> newTags = [];

  /*static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Restaurants',
      style: optionStyle,
    ),
    Text(
      'Index 1: Agenda',
      style: optionStyle,
    ),
    //ProfilePage(owner: widget.owner),
    Text(
      'Index 2: Profile',
      style: optionStyle,
    )
  ];*/

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late final screens = [
    //ListRestaurantsPage(newTags: newTags, customer: customer)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            SizedBox(width: 65),
            Icon(Icons.menu),
            SizedBox(width: 10),
            Text('Main page')
          ],
        ),
      ),
      body: Center(
        child: screens.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: 'Restaurants',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}