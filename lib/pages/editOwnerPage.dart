import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_tutorial/pages/ownerMainPage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_tutorial/models/dish.dart';
import 'package:flutter_tutorial/pages/mainPage.dart';
import 'package:flutter_tutorial/pages/profilePage.dart';
import 'package:flutter_tutorial/widgets/appbarWidget.dart';
import 'package:flutter_tutorial/widgets/profileWidget.dart';
import 'package:flutter_tutorial/widgets/TextFieldWidget.dart';
import 'package:flutter_tutorial/services/ownerService.dart';
import 'package:flutter_tutorial/models/customer.dart';
import 'package:email_validator/email_validator.dart';
import 'package:path/path.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:path_provider/path_provider.dart';

import '../models/owner.dart';

class editOwnerPage extends StatefulWidget {
  final Owner? owner;
  const editOwnerPage({Key? key, required this.owner}) : super(key: key);

  @override
  State<editOwnerPage> createState() => _editOwnerPageState();
}

class _editOwnerPageState extends State<editOwnerPage> {
  String imagePath = "";
  String _errorMessage = '';
  String? _initialEmail;
  String? _initialUsername;
  bool _isEditingName = false;
  bool _isEditingEmail = false;
  late File newImage = File("");
  late TextEditingController _customerNameController;
  late TextEditingController _emailController;
  bool buttonEnabled = false;

  final cloudinary = CloudinaryPublic('eduardferrecloud', 'oqpjo8a2', cache: false);
  
  @override
  void initState() {
    _initialEmail = widget.owner?.email;
    _initialUsername = widget.owner?.ownerName;
    _customerNameController = TextEditingController(text: _initialUsername);
    _emailController = TextEditingController(text: _initialEmail);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    OwnerService ownerService = OwnerService();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 32),
        physics: BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 24),
          ProfileWidget(
            imagePath: widget.owner!.profilePic,
            isEdit: true,
            onClicked: () async {
              var image =
                  await ImagePicker().pickImage(source: ImageSource.gallery);
              if (image == null) return;

              var directory = await getApplicationDocumentsDirectory();
              var name = basename(image.path);
              var imageFile = File('${directory.path}/$name');
              newImage = await File(image.path).copy(imageFile.path);
            },
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              controller: _customerNameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: translate('login_page.username'),
                  hintText: translate('login_page.new_username')),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15.0, bottom: 0),
            child: TextField(
              controller: _emailController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: translate('login_page.email'),
                  hintText: translate('login_page.new_email')),
              onChanged: (val) {
                validateEmail(val);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _errorMessage,
              style: TextStyle(color: Colors.red),
            ),
          ),
          Container(
            height: 50,
            width: 250,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(20)),
            child: TextButton(
              onPressed: () async {
                if ((_customerNameController.text.isNotEmpty) &&
                    (_emailController.text.isNotEmpty)) {
                  
                  var profilePic = "";
                  
                  if (newImage.path != "") {
                  try {
                    CloudinaryResponse response = await cloudinary.uploadFile(
                      CloudinaryFile.fromFile(newImage.path, folder: 'profilePics', resourceType: CloudinaryResourceType.Image),
                    );
                    
                    profilePic = response.secureUrl;

                  } on CloudinaryException catch (e) {

                    profilePic = widget.owner!.profilePic;
                  }
                  }
                  else {
                    profilePic = widget.owner!.profilePic;
                  }
                  
                  Owner? newowner = Owner(
                    ownerName: _customerNameController.text,
                    fullName: widget.owner!.fullName,
                    email: _emailController.text,
                    password: widget.owner!.password,
                    profilePic: profilePic,
                  );

                  newowner.id = widget.owner!.id;
                  newowner.listRestaurants = widget.owner!.listRestaurants;

                  var res = await ownerService.update(newowner, newowner.id);

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
                      builder: (context) => OwnerMainPage(
                        owner: newowner,
                        selectedIndex: 3,
                        transferRestaurantTags: voidListTags,
                        chatPage: "Inbox",
                      )),
                  );
                }
              },
              child: Text(
                translate('update'),
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

  Widget _editNameTextField() {
    if (_isEditingName)
      // ignore: curly_braces_in_flow_control_structures
      return Center(
        child: TextField(
          onSubmitted: (newValue) {
            setState(() {
              _initialUsername = newValue;
              _isEditingName = false;
            });
          },
          autofocus: true,
          controller: _customerNameController,
        ),
      );
    return InkWell(
      onTap: () {
        setState(() {
          _isEditingName = true;
        });
      },
      child: Text(
        _initialUsername!,
        // ignore: prefer_const_constructors
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.0,
        ),
      ),
    );
  }

    Widget _editEmailTextField() {
    if (_isEditingEmail)
      // ignore: curly_braces_in_flow_control_structures
      return Center(
        child: TextField(
          onSubmitted: (newValue) {
            setState(() {
              _initialEmail = newValue;
              _isEditingEmail = false;
            });
          },
          autofocus: true,
          controller: _emailController,
        ),
      );
    return InkWell(
      onTap: () {
        setState(() {
          _isEditingEmail = true;
        });
      },
      child: Text(
        _initialEmail!,
        // ignore: prefer_const_constructors
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.0,
        ),
      ),
    );
  }

  void validateEmail(String val) {
    if (val.isEmpty) {
      setState(() {
        _errorMessage = translate('login_page.email_empty');
        buttonEnabled = false;
      });
    } else if (!EmailValidator.validate(val, true)) {
      setState(() {
        _errorMessage = translate('login_page.email');
        buttonEnabled = false;
      });
    } else {
      setState(() {
        _errorMessage = "";
      });
    }
  }
}