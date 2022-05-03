import 'package:flutter/material.dart';
import 'package:flutter_tutorial/models/dish.dart';
import 'package:flutter_tutorial/widgets/appbarWidget.dart';
import 'package:flutter_tutorial/widgets/profileWidget.dart';
import 'package:flutter_tutorial/widgets/TextFieldWidget.dart';

class editProfilePage extends StatefulWidget {
  const editProfilePage({Key? key}) : super(key: key);

  @override
  State<editProfilePage> createState() => _editProfilePage();
}

class _editProfilePage extends State<editProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
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
          text: 'asdfasdf',

        ),*/
          ],
        ),
      );
}
