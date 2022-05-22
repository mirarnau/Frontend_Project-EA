// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_tutorial/pages/mainPage.dart';
import 'package:flutter_tutorial/models/customer.dart';

class NavDrawerChat extends StatelessWidget {
  final Customer? myCustomer;
  final String currentPage;

  const NavDrawerChat({Key? key, required this.myCustomer, required this.currentPage}) : super(key: key);

  List<DropdownMenuItem<String>> get foodStylesTags{
    List<DropdownMenuItem<String>> foodStylesItems = [
      const DropdownMenuItem(child: Text("Italian"),value: "Italian"),
      const DropdownMenuItem(child: Text("Asiatic"),value: "Asiatic"),
      const DropdownMenuItem(child: Text("Vegan"),value: "Vegan"),
      const DropdownMenuItem(child: Text("Mexican"),value: "Mexican"),
    ];
    return foodStylesItems;
  }

  @override
  Widget build(BuildContext context) {
    Color tileColorInbox = Color.fromARGB(255, 48, 48, 48);
    Color tileColorSent = Color.fromARGB(255, 48, 48, 48);

    if (currentPage == "Inbox"){
      tileColorInbox = Color.fromARGB(255, 96, 66, 64);
      tileColorSent = Color.fromARGB(255, 48, 48, 48);
    }
    if (currentPage == "Sent"){
      tileColorInbox = Color.fromARGB(255, 48, 48, 48);
      tileColorSent = Color.fromARGB(255, 96, 66, 64);
      
    }
    return Drawer(
      backgroundColor: Color.fromARGB(255, 48, 48, 48),
      child: ListView(
      children: <Widget>[
        Card(
          child: 
          Column(
            children:  [
              ListTile(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Color.fromARGB(255, 48, 48, 48)
                  )
                ),
                tileColor: tileColorInbox,
                iconColor: Color.fromARGB(255, 213, 94, 85),
                textColor: Colors.grey,
                leading: Icon (Icons.inbox),
                title: Text('Inbox'),
                trailing: const Text(
                  '+12',
                  style: TextStyle(
                    color: Colors.grey 
                  ),),
                  onTap:() {
                    List<String> voidListTags = [];
                    var route = MaterialPageRoute(
                      builder: (BuildContext context) =>
                          MainPage(customer: myCustomer, selectedIndex: 1, transferRestaurantTags: voidListTags, chatPage: "Inbox",));
                    
                    Navigator.of(context).push(route);
                  }
              ),
            ],
          )
        ),
        Card(
          child: 
          Column(
            children:  [
              ListTile(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Color.fromARGB(255, 48, 48, 48)
                  )
                ),
                tileColor: tileColorSent,
                iconColor: Color.fromARGB(255, 213, 94, 85),
                textColor: Colors.grey,
                leading: Icon (Icons.send),
                title: Text('Sent'),
                onTap:() {
                    List<String> voidListTags = [];
                    var route = MaterialPageRoute(
                      builder: (BuildContext context) =>
                          MainPage(customer: myCustomer, selectedIndex: 1, transferRestaurantTags: voidListTags, chatPage: "Sent",));
                    
                    Navigator.of(context).push(route);
                  }
              ),
            ],
          )
        ),
      ],
)
    );
  }
}