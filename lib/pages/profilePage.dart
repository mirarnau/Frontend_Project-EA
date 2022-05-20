import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:flutter_tutorial/widgets/accountSettingsWidget.dart';
import 'package:flutter_tutorial/widgets/appbarWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tutorial/widgets/iconWidget.dart';
import 'package:flutter_tutorial/widgets/profileWidget.dart';
import 'package:flutter_tutorial/models/customer.dart';
import 'package:flutter_tutorial/services/customerService.dart';
import 'package:flutter_tutorial/pages/editProfilePage.dart';

class ProfilePage extends StatefulWidget {
  final Customer? customer;
  static const keyDarkMode = 'key-dark-mode';
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
          const SizedBox(height: 24),

          buildDarkMode(),

          SettingsGroup(
            title: 'CONFIGURATION', 
            children: <Widget> [
              const SizedBox(height: 8),
              AccountPage(),
              buildNotifications(),
              buildLogout(),
              buildDeleteAccount(),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildName(String fullName, String email, String customerName) => Column(
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

  Widget buildNotifications() => SimpleSettingsTile(
    leading: IconWidget(
      color: Colors.orangeAccent, 
      icon: Icons.notifications
    ),
    title: 'Notifications',
    subtitle: '',
    child: Container(),
    onTap: () { 
      //
    },
  );

  Widget buildLogout() => SimpleSettingsTile(
    leading: IconWidget(
      color: Colors.blueAccent, 
      icon: Icons.logout
    ),
    title: 'Logout',
    subtitle: '',
    onTap: () { 
      //TODO: Add Logout method
      Settings.clearCache();
    },
  );

  Widget buildDeleteAccount() => SimpleSettingsTile(
    leading: IconWidget(
      color: Colors.redAccent, 
      icon: Icons.delete
    ),
    title: 'Delete Account',
    subtitle: '',
    onTap: () { 
      //TODO: Add delete method
    },
  );

  Widget buildDarkMode() => SwitchSettingsTile(
    settingKey: ProfilePage.keyDarkMode,
    leading: IconWidget(
      icon: Icons.dark_mode,
      color: Color(0xFF642ef3),
    ),
    title: 'Dark Mode',
    onChange: (isDarkMode) { /* NOOP */}
  );
}