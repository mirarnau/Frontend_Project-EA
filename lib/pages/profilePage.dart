import 'package:flutter/material.dart';
import 'package:flutter_tutorial/widgets/appbarWidget.dart';
import 'package:flutter_tutorial/widgets/profileWidget.dart';
import 'package:flutter_tutorial/models/customer.dart';
import 'package:flutter_tutorial/pages/editProfilePage.dart';

class ProfilePage extends StatefulWidget {
  final Customer? customer;
  const ProfilePage({Key? key, required this.customer}) : super(key: key);

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
            onClicked: () async {
              var route = MaterialPageRoute(
                builder: (BuildContext context) => editProfilePage(
                  customer: widget.customer,
                ),
              );
              Navigator.of(context).push(route);
            },
          ),
          const SizedBox(height: 24),
          buildName(widget.customer!.fullName, widget.customer!.email,
              (widget.customer!.customerName)),
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