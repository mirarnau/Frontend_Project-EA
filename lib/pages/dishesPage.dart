import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_tutorial/services/dishService.dart';
import 'package:flutter_tutorial/models/dish.dart';
import 'package:flutter_tutorial/widgets/dishWidget.dart';

class DishesPage extends StatefulWidget {
  const DishesPage({Key? key}) : super(key: key);

  @override
  State<DishesPage> createState() => _DishedPageState();
}

class _DishedPageState extends State<DishesPage> {
  DishApi dishService = DishApi();
  List<Dish>? listDishes;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getAllDishes();
  }

  Future<void> getAllDishes() async {
    listDishes = await dishService.getAllDishes();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (listDishes == null){
      return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 65),
              Icon(Icons.restaurant_menu), //Element at left
              SizedBox(
                  width:
                      10), //To add space between them, element in the middle.
              Text(translate('dishes_page.all')) //Element at right. Text is another widget.
            ],
          ),
        ),
        body: Text (translate('dishes_page.no_dish'),
                  style: TextStyle(
                    fontSize: 20
                  ),
        )
      );
    }
    return Scaffold(
        //Scaffold is a widget that contains other widgets.
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 65),
              Icon(Icons.restaurant_menu), //Element at left
              SizedBox(
                  width:
                      10), //To add space between them, element in the middle.
              Text(translate('dishes_page.all')) //Element at right. Text is another widget.
            ],
          ),
        ),
        body: ListView.builder(
            itemCount: listDishes?.length,
            itemBuilder: (context, index) {
              return CardDish(
                  title: listDishes![index].title,
                  price: listDishes![index].price.toString(),
                  rating: listDishes![index].rating.toString(),
                  thumbnailUrl: listDishes![index].imageUrl);
            }));
  }
}
