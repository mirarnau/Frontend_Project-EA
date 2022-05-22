// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
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
                  'Filter by style',
                  style: TextStyle(
                    color: Color.fromARGB(255, 197, 196, 196),
                  ),),
                subtitle: Text(
                  'Select the style of food',
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
                    child: const Text(
                      'ADD TAG',
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
                  'Filter by preferences',
                  style: TextStyle(
                    color: Color.fromARGB(255, 197, 196, 196),
                  ),),
                subtitle: Text(
                  'Select your preferences',
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
                    child: const Text(
                      'ADD TAG',
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

  