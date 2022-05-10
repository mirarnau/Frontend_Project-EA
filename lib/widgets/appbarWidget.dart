import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context) {
  IconData? icon;
  return AppBar(
    leading: BackButton(),
    elevation: 0,
    backgroundColor: Colors.transparent,
    actions: [
      IconButton(
        icon: Icon(icon),
        onPressed: () {},
      )
    ],
  );
}
