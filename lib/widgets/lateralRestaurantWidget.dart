import 'package:flutter/material.dart';
import 'package:flutter_tutorial/pages/mainPage.dart';
import 'package:flutter_tutorial/models/customer.dart';

class NavDrawer extends StatelessWidget {
  final Customer? customer;
  final List<String> previousTags;
  const NavDrawer({Key? key, required this.customer, required this.previousTags}) : super(key: key);

  List<DropdownMenuItem<String>> get foodStylesTags{
    List<DropdownMenuItem<String>> foodStylesItems = [
      const DropdownMenuItem(child: Text("Italian"),value: "Italian"),
      const DropdownMenuItem(child: Text("Asiatic"),value: "Asiatic"),
      const DropdownMenuItem(child: Text("Vegan"),value: "Vegan"),
      const DropdownMenuItem(child: Text("Mexican"),value: "Mexican"),
    ];
    return foodStylesItems;
  }

  List<DropdownMenuItem<String>> get extrasTags{
    List<DropdownMenuItem<String>> extrasTags = [
      const DropdownMenuItem(child: Text("Pets allowed"),value: "Pets allowed"),
      const DropdownMenuItem(child: Text("Live music"),value: "Live music"),
      const DropdownMenuItem(child: Text("For kids"),value: "For kids")
    ];
    return extrasTags;
  }

  @override
  Widget build(BuildContext context) {
    String selectedFoodStyle = "Italian";
    String selectedExtras = "Live music";
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 48, 48, 48),
      child: ListView(
      children: <Widget>[
        Card(
          child: 
          Column(
            children: [
              const ListTile(
                leading: Icon (Icons.restaurant),
                title: Text('Filter by style'),
                subtitle: Text('Select the style of food'),
                trailing: Icon(Icons.more_vert),
              ),
              
              DropdownButtonFormField(
                value: selectedFoodStyle,
                items: foodStylesTags, 
                onChanged: (String? newValue) { 
                  selectedFoodStyle = newValue!;
                  previousTags.add(selectedFoodStyle);
                 },
              ),
              TextButton(
                child: const Text(
                  'ADD TAG',
                  style: TextStyle(
                    color: Colors.green
                  ),
                ),
                onPressed:() {
                  {Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context)=> MainPage(customer: customer, selectedIndex: 0, transferRestaurantTags: previousTags))
                    );}
                 }
              )
            ],
          )
        ),
        Card(
          child: 
          Column(
            children: [
              const ListTile(
                leading: Icon (Icons.restaurant),
                title: Text('Filter by preferences'),
                subtitle: Text('Select your preferences'),
                trailing: Icon(Icons.more_vert),
              ),
              DropdownButtonFormField(
                value: selectedExtras,
                items: extrasTags, 
                onChanged: (String? newValue) { 
                  selectedExtras = newValue!;
                  previousTags.add(selectedExtras);
                 },
              ),
              TextButton(
                child: const Text(
                  'ADD TAG',
                  style: TextStyle(
                    color: Colors.green
                  ),
                ),
                onPressed:() {
                  {Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context)=> MainPage(customer: customer, selectedIndex: 0, transferRestaurantTags: previousTags))
                    );}
                 }
              )
            ],
          )
        ),
      ],
)
    );
  }
}