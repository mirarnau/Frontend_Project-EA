import 'package:flutter/material.dart';
import 'package:flutter_tutorial/models/customer.dart';
import 'package:flutter_tutorial/services/customerService.dart';


class CreateUser extends StatefulWidget {
  const CreateUser({ Key? key }) : super(key: key);

  @override
  State<CreateUser> createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUser> {
  final _formKey = GlobalKey<FormState>();

  final customernameController = TextEditingController();
  final fullnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    customernameController.dispose();
    fullnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build (BuildContext context) {
    
    CustomerService customerService = CustomerService();

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
              controller: customernameController,
              decoration: const InputDecoration(  
                icon: Icon(Icons.person),  
                hintText: 'Enter your username',  
                labelText: 'Username',  
              ),
            ),
            TextField(  
              controller: fullnameController,
              decoration: const InputDecoration(  
                icon: Icon(Icons.calendar_month),  
                hintText: 'Enter your full name',  
                labelText: 'Full name',  
              ),
            ),
            TextField(  
              controller: emailController,
              decoration: const InputDecoration(  
                icon: Icon(Icons.password),  
                hintText: 'Enter your email',  
                labelText: 'Email',  
              ),
            ),
            TextField(  
              controller: emailController,
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
                  if ((customernameController.text.isNotEmpty) && (fullnameController.text.isNotEmpty) && (emailController.text.isNotEmpty)  && (passwordController.text.isNotEmpty)){
                    Customer newUser = Customer(customerName: customernameController.text, fullName: fullnameController.text, email: emailController.text, password: passwordController.text);
                    await customerService.addCustomer(newUser);
                    /*
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ()),
                    );
                    */
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

