import 'package:flutter_tutorial/widgets/appbarWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tutorial/widgets/profileWidget.dart';
import 'package:flutter_tutorial/models/customer.dart';
import 'package:flutter_tutorial/services/customerService.dart';

class ProfilePage extends StatefulWidget {
  final String fullName;
  final String email;
  final String customerName;
  const ProfilePage(
      {Key? key,
      required this.fullName,
      required this.email,
      required this.customerName})
      : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath:
                "https://flyclipart.com/thumb2/user-icon-png-pnglogocom-133466.png",
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          buildName(widget.fullName, widget.email, widget.customerName),
        ],
      ),
    );
  }

  Widget buildName(String fullName, String email, String customerName) =>
      Column(
        children: [
          Text(
            customerName,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            email,
            style: TextStyle(color: Colors.grey),
          ),
          Text(
            fullName,
            style: TextStyle(color: Colors.grey),
          )
        ],
      );
}
