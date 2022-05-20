import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:flutter_tutorial/widgets/iconWidget.dart';

class AccountPage extends StatelessWidget {
  static const keyLanguage = 'key-language';
  
  @override
  Widget build(BuildContext context) => SimpleSettingsTile(
    title: 'Account Settings',
    subtitle: 'Language',
    leading: IconWidget(
      color: Colors.green, 
      icon: Icons.person
    ),
    child: SettingsScreen(
      title: 'Account Settings',
      children: <Widget> [
        buildLanguage(),
      ],
    ),
  );

  Widget buildLanguage() => DropDownSettingsTile(
    settingKey: keyLanguage,
    title: 'Language',
    selected: 1,
    values: <int, String> {
      1: 'English',
      2: 'Spanish',
      3: 'Catalan',
    },
    onChange: (language) {/* */},
  );
}
