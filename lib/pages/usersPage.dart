import 'package:flutter/material.dart';
import 'package:flutter_tutorial/models/user.dart';
import 'package:flutter_tutorial/services/userService.dart';
import 'package:flutter_tutorial/pages/createUserPage.dart';
import 'package:flutter_tutorial/widgets/userWidget.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({ Key? key }) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State <UsersPage> {

  UserService userService = UserService();
  List <User>? listUsers;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    getAllUsers();
  }

  Future <void> getAllUsers() async {
    listUsers = await userService.getAllUsers();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (listUsers == null){
      return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              SizedBox(width: 65),
              Icon(Icons.restaurant_menu), //Element at left
              SizedBox(
                  width:
                      10), //To add space between them, element in the middle.
              Text('All dishes') //Element at right. Text is another widget.
            ],
          ),
        ),
        body: const Text ('There are no users yet',
                  style: TextStyle(
                    fontSize: 20
                  ),
        ),
        floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateUser()));
        }),
      );
    }
    return Scaffold(  
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
          SizedBox(width: 86), 
          Icon(Icons.people), 
          SizedBox(width: 10), 
          Text('Users') 
        ],),
      ),
      body: isLoading
        ? const Center(child: CircularProgressIndicator())  //Center() is also a widget that centralizes whatever is inside it.
        : ListView.builder(
            itemCount: listUsers?.length, 
            itemBuilder: (context, index){
              return UserWidget(
                name: listUsers![index].name,
                age: listUsers![index].age,
                passsword: listUsers![index].password
              );
            }   
          ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateUser()));
        }),
        
    );
  }
}