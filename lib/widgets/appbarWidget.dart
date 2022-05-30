import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context) {
  IconData? icon;
  return AppBar(
    leading: BackButton(),
    elevation: 0,
    actions: [
      IconButton(
        icon: Icon(icon),
        onPressed: () {},
      )
    ],
  );
}
