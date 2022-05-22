import 'package:flutter/material.dart';
import 'package:flutter_tutorial/models/owner.dart';
import 'package:flutter_tutorial/pages/listRestaurantsPage.dart';
import 'package:flutter_tutorial/pages/profilePage.dart';
import 'package:flutter_tutorial/services/ownerService.dart';

class OwnerMainPage extends StatefulWidget {
  final Owner? owner;
  
  OwnerMainPage({Key? key, required this.owner}) : super(key: key);

  @override
  _OwnerMainPageState createState() => _OwnerMainPageState();
}

class _OwnerMainPageState extends State<OwnerMainPage> {
  int _selectedIndex = 0;
  late final Owner? _owner = widget.owner;

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
    //ListRestaurantsPage(owner: _owner)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            SizedBox(width: 65),
            Icon(Icons.menu),
            SizedBox(width: 10),
            Text('Main page')
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
            icon: Icon(Icons.chat_bubble),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_agenda_rounded),
            label: 'Agenda',
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