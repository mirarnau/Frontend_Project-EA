// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_tutorial/models/owner.dart';
import 'package:flutter_tutorial/models/post.dart';
import 'package:flutter_tutorial/models/restaurant.dart';
import 'package:flutter_tutorial/pages/mainPage.dart';
import 'package:flutter_tutorial/pages/ownerMainPage.dart';
import 'package:flutter_tutorial/pages/wallPageOwner.dart';
import 'package:flutter_tutorial/services/postService.dart';
import 'package:flutter_tutorial/services/restaurantService.dart';


class CreatePostPage extends StatefulWidget {
  final Owner? owner;
  const CreatePostPage({Key? key, required this.owner}) : super(key: key);

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  PostService postService = PostService();
  RestaurantService restaurantService = RestaurantService();
  bool isLoading = true;
  bool _isEmpty = true;
  List<Restaurant>? myRestaurants = [];
  List<String> myTags = [];

  List<DropdownMenuItem<String>> listRestaurants = [];
  String selectedRestaurant = "";

  final restaurantController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    restaurantController.dispose();
    descriptionController.dispose();

    super.dispose();
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  

  AlertDialog alert = AlertDialog(
      title: Text(
        "Empty fields",
        style: TextStyle(color: Colors.red),
      ),
      content: Text('Some fields are empty, please fill them'),
      actions: [
        okButton,
      ],
    );
  }

  @override
  void initState() {
    getRestaurants();
    super.initState();
  }

  Future<void> getRestaurants() async {
      setState(() => isLoading = true);
      List<Restaurant>? rests = await restaurantService.filterRestaurants(myTags);

      for (Restaurant restaurant in rests!) {
        if (restaurant.owner == widget.owner!.id) {
          myRestaurants!.add(restaurant);
        }
      }
      if(myRestaurants!.isEmpty) {
        _isEmpty = true;
      }
      else {
        for (var i = 0; i < myRestaurants!.length; i++){
          DropdownMenuItem<String> menuItem = DropdownMenuItem(
            child: Text(
              myRestaurants![i].restaurantName
            ),
            value: myRestaurants![i].restaurantName,
          );
          listRestaurants.add(menuItem);
        }
        _isEmpty = false;
      }
      setState(() => {
        isLoading = false,
        selectedRestaurant = listRestaurants[0].value.toString()
        });
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('New post')
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Image(
              image: NetworkImage('https://www.pngitem.com/pimgs/m/33-330111_album-icon-png-transparent-png.png')
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 0.0, 15.0, 0.0),
            child: Text(
              'From which restaurant profile you want to upload the photo?',
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
            child: DropdownButtonFormField(
              style: TextStyle(
                color:Theme.of(context).highlightColor, 
              ),
              iconDisabledColor: Theme.of(context).backgroundColor,
              dropdownColor: Theme.of(context).hoverColor,
              borderRadius: BorderRadius.circular(20),
              value: selectedRestaurant,
              items: listRestaurants, 
              onChanged: (String? newValue) { 
                selectedRestaurant = newValue!;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 30.0, 15.0, 0.0),
            child: Text(
              'Add a description for this post',
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Expanded(
            child:
            Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 10.0, 15.0, 0.0),
              child: TextFormField(
                controller: descriptionController,
                style: TextStyle(
                  color: Theme.of(context).shadowColor,
                ),
                expands: true,
                maxLines: null,
                minLines: null,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 0.2),
                ),
                  hintText: 'Write here whatever you want',
                  hintStyle: TextStyle(
                    color: Theme.of(context).shadowColor
                  )
                ),
              ),
            )
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.send),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () async {
          late Restaurant selected;
          for (var i = 0; i < myRestaurants!.length; i++){
            if (myRestaurants![i].restaurantName == selectedRestaurant){
              selected = myRestaurants![i];
            }
          }
          print(selected.photos[0]);
          Post newPost = Post(creator: selectedRestaurant, profileImage: selected.photos[0], description: descriptionController.text, postImageUrl: "https://fastly.4sqi.net/img/general/600x600/87934174_fYCFEYx2RyfNan0T3vKz67cf54y5JvDpx2E1GrycxE4.jpg");
          await postService.addPost(newPost);
          var routes = MaterialPageRoute(
            builder: (BuildContext context) => 
            OwnerMainPage(owner: widget.owner, selectedIndex: 3, transferRestaurantTags: [], chatPage: "Sent")
          );
          Navigator.of(context).push(routes);
        },
      ),
    );
  }
}
  
