import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_tutorial/pages/mainPage.dart';
import 'package:flutter_tutorial/models/customer.dart';

class NavDrawerChat extends StatelessWidget {
  const NavDrawerChat({Key? key}) : super(key: key);

  List<DropdownMenuItem<String>> get foodStylesTags{
    List<DropdownMenuItem<String>> foodStylesItems = [
      DropdownMenuItem(child: Text(translate('food_tags.italian')), value: "Italian"),
      DropdownMenuItem(child: Text(translate('food_tags.asiatic')), value: "Asiatic"),
      DropdownMenuItem(child: Text(translate('food_tags.vegan')), value: "Vegan"),
      DropdownMenuItem(child: Text(translate('food_tags.mexican')), value: "Mexican"),
    ];
    return foodStylesItems;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(255, 48, 48, 48),
      child: ListView(
      children: <Widget>[
        Card(
          child: 
          Column(
            children: [
              ListTile(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Color.fromARGB(255, 48, 48, 48)
                  )
                ),
                tileColor: Color.fromARGB(255, 48, 48, 48),
                iconColor: Color.fromARGB(255, 213, 94, 85),
                textColor: Colors.grey,
                leading: Icon (Icons.inbox),
                title: Text(translate('tickets_page.inbox')),
                trailing: Text(
                  '+12',
                  style: TextStyle(
                    color: Colors.grey 
                  ),)
              ),
            ],
          )
        ),
        Card(
          child: 
          Column(
            children: [
              ListTile(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Color.fromARGB(255, 48, 48, 48)
                  )
                ),
                tileColor: Color.fromARGB(255, 48, 48, 48),
                iconColor: Color.fromARGB(255, 213, 94, 85),
                textColor: Colors.grey,
                leading: Icon (Icons.send),
                title: Text(translate('tickets_page.sent')),
              ),
            ],
          )
        ),
      ],
      )
    );
  }
}