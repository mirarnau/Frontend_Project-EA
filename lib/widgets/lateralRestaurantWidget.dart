// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_tutorial/pages/mainPage.dart';
import 'package:flutter_tutorial/models/customer.dart';
import 'package:flutter_tutorial/widgets/mapWidget.dart';


class NavDrawer extends StatefulWidget {
  final Customer? customer;
  final List<String> previousTags;
  final double previousMaxDistance;
  const NavDrawer({Key? key, required this.customer, required this.previousTags, required this.previousMaxDistance}) : super(key: key);

  @override
  State<NavDrawer> createState() => _NavDrawer_State();
}


  class _NavDrawer_State extends State<NavDrawer>{
    double newMaxDist = 0.0;

    final distanceController = TextEditingController();

    bool foodStyleVisible = false;
    bool extrasVisible = false;
    bool distanceVisible = false;

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
      backgroundColor: Theme.of(context).backgroundColor,
      child: ListView(
      children: <Widget>[
        Card(
          child: 
          Column(
            children: [
               ListTile(
                 tileColor: Theme.of(context).backgroundColor,
                leading: Icon (
                  Icons.restaurant,
                  color: Theme.of(context).primaryColor),
                title: Text(
                  translate('restaurants_page.filter_style'),
                  style: TextStyle(
                    color: Theme.of(context).highlightColor,
                  ),),
                subtitle: Text(
                  translate('restaurants_page.select_style'),
                  style: TextStyle(
                    color: Theme.of(context).shadowColor
                  ),),
                trailing: Icon(
                  Icons.more_vert,
                  color: Theme.of(context).primaryColor),
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
                  color: Theme.of(context).backgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        DropdownButtonFormField(
                          style: TextStyle(
                            color:Theme.of(context).highlightColor, 
                          ),
                          iconDisabledColor: Theme.of(context).backgroundColor,
                          dropdownColor: Theme.of(context).hoverColor,
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
                        builder: (BuildContext context)=> MainPage(customer: widget.customer, selectedIndex: 0, transferRestaurantTags: widget.previousTags, chatPage: "Inbox", maxDistance: 99999.0, filterType: "tags"))
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
                tileColor: Theme.of(context).backgroundColor,
                leading: Icon (
                  Icons.family_restroom,
                  color: Theme.of(context).primaryColor),
                title: Text(
                  translate('restaurants_page.filter_pref'),
                  style: TextStyle(
                    color: Theme.of(context).highlightColor,
                  ),),
                subtitle: Text(
                  translate('restaurants_page.select_pref'),
                  style: TextStyle(
                    color: Theme.of(context).shadowColor,
                  ),),
                trailing: Icon(
                  Icons.more_vert,
                  color: Theme.of(context).primaryColor),
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
                  color: Theme.of(context).backgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        DropdownButtonFormField(
                          style: TextStyle(
                            color:Theme.of(context).highlightColor, 
                          ),
                          borderRadius: BorderRadius.circular(20),
                          iconDisabledColor: Theme.of(context).backgroundColor,
                          dropdownColor: Theme.of(context).hoverColor,
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
                              builder: (BuildContext context)=> MainPage(customer: widget.customer, selectedIndex: 0, transferRestaurantTags: widget.previousTags, chatPage: "Inbox", maxDistance: 99999.0, filterType: "tags"))
                              );}
                          }
                        ), 
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ),
        Card(
          child: 
          Column(
            children: [
              ListTile(
                tileColor: Theme.of(context).backgroundColor,
                leading: Icon (
                  Icons.loupe,
                  color: Theme.of(context).primaryColor),
                title: Text(
                  'Filter by distance',
                  style: TextStyle(
                    color: Theme.of(context).highlightColor,
                  ),),
                subtitle: Text(
                  'Select distance (Km)',
                  style: TextStyle(
                    color: Theme.of(context).shadowColor,
                  ),),
                trailing: Icon(
                  Icons.more_vert,
                  color: Theme.of(context).primaryColor),
                onTap: () {
                  if (extrasVisible == false){
                    distanceVisible = true;
                  }
                  else {
                    distanceVisible = false;
                  }
                  setState(() {});
                },
              ),
              Visibility(
                visible: distanceVisible == true ? true:false ,
                child: Container(
                  color: Theme.of(context).backgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextFormField(
                            controller: distanceController,
                            style: TextStyle(
                                color: Theme.of(context).shadowColor,
                              ),
                            decoration: InputDecoration(
                              hintText: 'Distance in km',
                              hintStyle: TextStyle(
                                color: Theme.of(context).shadowColor
                              )
                            ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5.0, 13.0, 5.9, 0.0),
                          child: Text(
                            'Current distance: ${widget.previousMaxDistance/1000} km'
                          ),
                        ),
                        TextButton(
                          child: Text(
                            'DONE',
                            style: TextStyle(
                              color: Colors.green
                            ),
                          ),
                          onPressed:() {
                            {Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context)=> MainPage(customer: widget.customer, selectedIndex: 0, transferRestaurantTags: const [], chatPage: "Inbox", maxDistance: (double.parse(distanceController.text))*1000, filterType: "distance"))
                              );}
                          }
                        ), 
                      ],
                    ),
                  ),
                ),
              ),
              
              
            ],
          )
        ),
      ],
)
    );
}


}

  