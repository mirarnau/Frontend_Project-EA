// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_tutorial/models/owner.dart';
import 'package:flutter_tutorial/pages/mainPage.dart';
import 'package:flutter_tutorial/models/owner.dart';

import '../pages/indexPage.dart';
import '../pages/ownerMainPage.dart';

class OwnerNavDrawerChat extends StatelessWidget {
  final Owner? myOwner;
  final String currentPage;

  const OwnerNavDrawerChat({Key? key, required this.myOwner, required this.currentPage}) : super(key: key);

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
    Color tileColorInbox = Theme.of(context).backgroundColor;
    Color tileColorSent = Theme.of(context).backgroundColor;

    if (currentPage == "Inbox"){
      tileColorInbox = Theme.of(context).hoverColor;
      tileColorSent = Theme.of(context).backgroundColor;
    }
    if (currentPage == "Sent"){
      tileColorInbox = Theme.of(context).backgroundColor;
      tileColorSent = Theme.of(context).hoverColor;
      
    }
    return Drawer(
      backgroundColor: Theme.of(context).backgroundColor,
      child: ListView(
      children: <Widget>[
        Card(
          child: 
          Column(
            children:  [
              ListTile(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Theme.of(context).backgroundColor
                  )
                ),
                tileColor: tileColorInbox,
                iconColor: Theme.of(context).primaryColor,
                textColor: Theme.of(context).shadowColor,
                leading: Icon (Icons.inbox),
                title: Text(translate('tickets_page.inbox')),
                trailing: Text(
                  '+12',
                  style: TextStyle(
                    color: Theme.of(context).shadowColor
                  ),),
                  onTap:() {
                    List<String> voidListTags = [];
                    var route = MaterialPageRoute(
                      builder: (BuildContext context) =>
                          OwnerMainPage(owner: myOwner, selectedIndex: 1, transferRestaurantTags: voidListTags, chatPage: "Inbox",));
                    
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
                    color: Theme.of(context).backgroundColor
                  )
                ),
                tileColor: tileColorSent,
                iconColor: Theme.of(context).primaryColor,
                textColor: Theme.of(context).shadowColor,
                leading: Icon (Icons.send),
                title: Text(translate('VideoCall')),
                onTap:() {
                    List<String> voidListTags = [];
                    var route = MaterialPageRoute(
                      builder: (BuildContext context) =>
                          VideocallPage());
                    
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