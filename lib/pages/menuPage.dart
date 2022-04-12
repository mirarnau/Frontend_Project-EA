import 'package:flutter/material.dart';
import 'package:flutter_tutorial/pages/dishesPage.dart';
import 'package:flutter_tutorial/pages/loginPage.dart';
import 'package:flutter_tutorial/widgets/menuButton.dart';


class MenuPage extends StatefulWidget {
  const MenuPage({ Key? key }) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
          Icon(Icons.restaurant_menu), 
          SizedBox(width: 10), 
          Text('Main menu') 
        ],),
      ),
      
      
      body: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  LoginPage()),
                );
                  },
                  child: MenuButtonWidget(
                    sectionName: "Users", 
                    urlImage: "https://supplychainbeyond.com/wp-content/uploads/2017/10/restaurant-service-and-supply-chain-1.jpg"),
                ),
                
                InkWell(
                  onTap: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DishesPage()),
                );
                  },
                  
                  child: MenuButtonWidget(
                    sectionName: "Dishes", 
                    urlImage: "https://static.hungrynaki.com/hungrynaki-v4/restaurants/the_royal_restaurant/meta/the_royal_restaurant_cover_1624864333466.jpeg"
                  )
                )
                
              ],)
    );
  }





}