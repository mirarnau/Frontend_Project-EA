import 'package:flutter/material.dart';
import 'package:flutter_tutorial/models/dish.dart';
import 'package:flutter_tutorial/pages/mainPage.dart';
import 'package:flutter_tutorial/pages/profilePage.dart';
import 'package:flutter_tutorial/widgets/appbarWidget.dart';
import 'package:flutter_tutorial/widgets/profileWidget.dart';
import 'package:flutter_tutorial/widgets/TextFieldWidget.dart';
import 'package:flutter_tutorial/services/customerService.dart';
import 'package:flutter_tutorial/models/customer.dart';

class editProfilePage extends StatefulWidget {
  final Customer? customer;
  const editProfilePage({Key? key, required this.customer}) : super(key: key);

  @override
  State<editProfilePage> createState() => _editProfilePage();
}

class _editProfilePage extends State<editProfilePage> {
  final customernameController = TextEditingController();
  final emailController = TextEditingController();
  bool buttonEnabled = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CustomerService customerService = CustomerService();
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 32),
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath:
                'https://flyclipart.com/thumb2/user-icon-png-pnglogocom-133466.png',
            isEdit: true,
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          /*TextFieldWidget(
            label: 'Full Name',
            text: widget.fullName,
            onChanged: (fullName) {},
          ),*/
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              controller: customernameController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User name',
                  hintText: 'New user name'),
            ),
          ),
          /*TextFieldWidget(
            label: 'Email',
            text: widget.email,
            onChanged: (email) {},
          ),*/
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15.0, bottom: 0),
            child: TextField(
              controller: emailController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  hintText: 'New email'),
            ),
          ),
          Container(
            height: 50,
            width: 250,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(20)),
            child: TextButton(
              onPressed: () async {
                if ((customernameController.text.isNotEmpty) &&
                    (emailController.text.isNotEmpty)) {
                  Customer? newcustomer = Customer(
                    customerName: customernameController.text, 
                    fullName: widget.customer!.fullName, 
                    email: emailController.text,
                    password: widget.customer!.password);

                  bool res = await customerService.update(
                      newcustomer, widget.customer!.id);
                  setState(() {
                    buttonEnabled = true;
                  });
                  if (res == false) {
                    //Codi de que hi ha hagut un error.
                    return;
                  }
                  List<String> voidListTags = [];
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MainPage(
                          customer: newcustomer, 
                          selectedIndex: 1, 
                          transferRestaurantTags: voidListTags)
                        ),
                  );
                }
              },
              child: const Text(
                'Update',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
          const SizedBox(
            height: 130,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 0),
          ),
        ],
      ),
    );
  }
}
