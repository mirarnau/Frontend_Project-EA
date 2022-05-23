// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_tutorial/pages/mainPage.dart';
import 'package:flutter_tutorial/models/customer.dart';


class NavDrawer extends StatefulWidget {
  final Customer? customer;
  final List<String> previousTags;
  const NavDrawer({Key? key, required this.customer, required this.previousTags}) : super(key: key);

  @override
  State<NavDrawer> createState() => _NavDrawer_State();
}


  class _NavDrawer_State extends State<NavDrawer>{

    bool foodStyleVisible = false;
    bool extrasVisible = false;

    String selectedFoodStyle = "Italian";
    String selectedExtras = "Live music";

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
    void initState() {
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    

    return Drawer(
      backgroundColor: const Color.fromARGB(255, 48, 48, 48),
      child: ListView(
      children: <Widget>[
        Card(
          child: 
          Column(
            children: [
               ListTile(
                 tileColor: const Color.fromARGB(255, 48, 48, 48),
                leading: Icon (
                  Icons.restaurant,
                  color: Color.fromARGB(255, 213, 94, 85),),
                title: Text(
                  translate('restaurants_page.filter_style'),
                  style: TextStyle(
                    color: Color.fromARGB(255, 197, 196, 196),
                  ),),
                subtitle: Text(
                  translate('restaurants_page.select_style'),
                  style: TextStyle(
                    color: Color.fromARGB(255, 118, 117, 117)
                  ),),
                trailing: Icon(
                  Icons.more_vert,
                  color: Color.fromARGB(255, 213, 94, 85)),
                onTap: (){
                  if (foodStyleVisible == false){
                    foodStyleVisible = true;
                  }
                  else {
                    foodStyleVisible = false;
                  }
                  setState(() {});
                },
              ),
              Visibility(
                visible: foodStyleVisible == true ? true:false ,
                child: Container(
                  color: const Color.fromARGB(255, 48, 48, 48),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        DropdownButtonFormField(
                          style: TextStyle(
                            color:Color.fromARGB(255, 197, 196, 196), 
                          ),
                          iconDisabledColor: const Color.fromARGB(255, 48, 48, 48),
                          dropdownColor: Color.fromARGB(255, 167, 108, 108),
                          borderRadius: BorderRadius.circular(20),
                    value: selectedFoodStyle,
                    items: foodStylesTags, 
                    onChanged: (String? newValue) { 
                      selectedFoodStyle = newValue!;
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
                      widget.previousTags.add(selectedFoodStyle);
                      {Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context)=> MainPage(customer: widget.customer, selectedIndex: 0, transferRestaurantTags: widget.previousTags, chatPage: "Inbox",))
                        );}
                     }
              )

                      ],
                    ),
                  ),
                ),
              )
              
            ],
          )
        ),
        Card(
          child: 
          Column(
            children: [
              ListTile(
                tileColor: const Color.fromARGB(255, 48, 48, 48),
                leading: Icon (
                  Icons.family_restroom,
                  color: Color.fromARGB(255, 213, 94, 85),),
                title: Text(
                  translate('restaurants_page.filter_pref'),
                  style: TextStyle(
                    color: Color.fromARGB(255, 197, 196, 196),
                  ),),
                subtitle: Text(
                  translate('restaurants_page.select_pref'),
                  style: TextStyle(
                    color: Color.fromARGB(255, 118, 117, 117),
                  ),),
                trailing: Icon(
                  Icons.more_vert,
                  color: Color.fromARGB(255, 213, 94, 85)),
                onTap: () {
                  if (extrasVisible == false){
                    extrasVisible = true;
                  }
                  else {
                    extrasVisible = false;
                  }
                  setState(() {});
                },
              ),
              Visibility(
                visible: extrasVisible == true ? true:false ,
                child: Container(
                  color: const Color.fromARGB(255, 48, 48, 48),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        DropdownButtonFormField(
                          style: TextStyle(
                            color:Color.fromARGB(255, 197, 196, 196), 
                          ),
                          borderRadius: BorderRadius.circular(20),
                          iconDisabledColor: const Color.fromARGB(255, 48, 48, 48),
                          dropdownColor: Color.fromARGB(255, 167, 108, 108),
                    value: selectedExtras,
                    items: extrasTags, 
                    onChanged: (String? newValue) { 
                      selectedExtras = newValue!;
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
                      widget.previousTags.add(selectedExtras);
                      {Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context)=> MainPage(customer: widget.customer, selectedIndex: 0, transferRestaurantTags: widget.previousTags, chatPage: "Inbox",))
                        );}
                    }
              )
                      ],
                    ),
                  ),
                ),
              )
              
            ],
          )
        ),
      ],
)
    );
}


}

  