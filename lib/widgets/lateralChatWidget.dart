import 'package:flutter/material.dart';
import 'package:flutter_tutorial/pages/mainPage.dart';
import 'package:flutter_tutorial/models/customer.dart';

class NavDrawerChat extends StatelessWidget {
  const NavDrawerChat({Key? key}) : super(key: key);

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
    return Drawer(
      backgroundColor: Color.fromARGB(255, 48, 48, 48),
      child: ListView(
      children: <Widget>[
        Card(
          child: 
          Column(
            children: const [
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
                title: Text('Inbox'),
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
            children: const [
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
                title: Text('Sent'),
              ),
            ],
          )
        ),
      ],
)
    );
  }
}