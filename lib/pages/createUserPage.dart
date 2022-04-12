import 'package:flutter/material.dart';
import 'package:flutter_tutorial/pages/usersPage.dart';
import 'package:flutter_tutorial/models/user.dart';
import 'package:flutter_tutorial/services/userService.dart';


class CreateUser extends StatefulWidget {
  const CreateUser({ Key? key }) : super(key: key);

  @override
  State<CreateUser> createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUser> {
  final _formKey = GlobalKey<FormState>();

  late String name;
  late String age;
  late String password;

  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    ageController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build (BuildContext context) {
    
    UserService userService = UserService();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
          SizedBox(width: 45), 
          Icon(Icons.person_add),
          SizedBox(width: 10), 
          Text('Create new user') 
        ],),
      ),

      body: Form(
        
        key: _formKey,  
        child: Column(  
          crossAxisAlignment: CrossAxisAlignment.start,  
          children: <Widget>[ 
            const Padding(padding: EdgeInsets.only(left: 40)),
            TextField(  
              controller: nameController,
              decoration: const InputDecoration(  
                icon: Icon(Icons.person),  
                hintText: 'Enter your name',  
                labelText: 'Name',  
              ),
            ),
            TextField(  
              controller: ageController,
              decoration: const InputDecoration(  
                icon: Icon(Icons.calendar_month),  
                hintText: 'Enter your age',  
                labelText: 'Age',  
              ),
            ),
            TextField(  
              controller: passwordController,
              decoration: const InputDecoration(  
                icon: Icon(Icons.password),  
                hintText: 'Enter your password',  
                labelText: 'Password',  
              ),
            ),
            Container(  
              padding: const EdgeInsets.only(left: 150.0, top: 40.0),  
              child: TextButton(  
                child: const Text('Done'),  
                onPressed: () async {  
                  if ((nameController.text.isNotEmpty) && (ageController.text.isNotEmpty) && (passwordController.text.isNotEmpty)){
                    User newUser = User(name: nameController.text, age: ageController.text, password: passwordController.text);
                    await userService.addUser(newUser);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const UsersPage()),
                    );
                  }
                  else{
                    showDialog(
                      context: context, 
                      builder: (context){
                        return AlertDialog(
                          content: Text (passwordController.text),
                        );
                      },
                    );
                  }
                }, 
              )),  
          ]
        )
      )
    );
  }
}

