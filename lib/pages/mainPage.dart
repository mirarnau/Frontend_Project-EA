import 'package:flutter/material.dart';
import 'package:flutter_tutorial/models/customer.dart';
import 'package:flutter_tutorial/pages/listRestaurantsPage.dart';
import 'package:flutter_tutorial/pages/profilePage.dart';
import 'package:flutter_tutorial/services/customerService.dart';
import 'package:flutter_tutorial/widgets/profileWidget.dart';
import 'editProfilePage.dart';

class MainPage extends StatefulWidget {
  final Customer? customer;
  late final int selectedIndex;
  final List<String> transferRestaurantTags;
  MainPage({Key? key, required this.customer, required this.selectedIndex, required this.transferRestaurantTags}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final Customer? _customer = widget.customer;
  late int _selectedIndex = widget.selectedIndex;

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
    //ProfilePage(customer: widget.customer),
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
    ListRestaurantsPage(newTags: widget.transferRestaurantTags, customer: _customer),
    const Center(child: Text('Chat', style: TextStyle(fontSize: 60))),
    const Center(child: Text('Agenda', style: TextStyle(fontSize: 60))),
    ProfilePage(customer: _customer),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*
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
      */
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
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}