import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_tutorial/pages/mainPage.dart';
import 'package:flutter_tutorial/models/customer.dart';

class NavDrawer extends StatelessWidget {
  final Customer? customer;
  final List<String> previousTags;
  const NavDrawer({Key? key, required this.customer, required this.previousTags}) : super(key: key);

  List<DropdownMenuItem<String>> get foodStylesTags{
    List<DropdownMenuItem<String>> foodStylesItems = [
      DropdownMenuItem(child: Text(translate('food_tags.italian')), value: "Italian"),
      DropdownMenuItem(child: Text(translate('food_tags.asiatic')), value: "Asiatic"),
      DropdownMenuItem(child: Text(translate('food_tags.vegan')), value: "Vegan"),
      DropdownMenuItem(child: Text(translate('food_tags.mexican')), value: "Mexican"),
    ];
    return foodStylesItems;
  }

  List<DropdownMenuItem<String>> get extrasTags{
    List<DropdownMenuItem<String>> extrasTags = [
      DropdownMenuItem(child: Text(translate('food_tags.pets')), value: "Pets allowed"),
      DropdownMenuItem(child: Text(translate('food_tags.live')), value: "Live music"),
      DropdownMenuItem(child: Text(translate('food_tags.kids')), value: "For kids")
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
              ListTile(
                leading: Icon (Icons.restaurant),
                title: Text(translate('restaurants_page.filter_style')),
                subtitle: Text(translate('restaurants_page.select_style')),
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
                child: Text(
                  translate('food_tags.add').toUpperCase(),
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
              ListTile(
                leading: Icon (Icons.restaurant),
                title: Text(translate('restaurants_page.filter_pref')),
                subtitle: Text(translate('restaurants_page.select_pref')),
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
                child: Text(
                  translate('food_tags.add').toUpperCase(),
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