import 'package:flutter/foundation.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_tutorial/pages/accountSettings.dart';
import 'package:flutter_tutorial/pages/emailPage.dart';
import 'package:flutter_tutorial/services/customerService.dart';
import 'package:flutter_tutorial/services/loginService.dart';
import 'package:flutter_tutorial/widgets/appbarWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tutorial/widgets/iconWidget.dart';
import 'package:flutter_tutorial/widgets/profileWidget.dart';
import 'package:flutter_tutorial/models/customer.dart';
import 'package:flutter_tutorial/pages/editProfilePage.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import 'loginPage.dart';

class ProfilePage extends StatefulWidget {
  final Customer? customer;
  static const keyDarkMode = 'key-dark-mode';
  const ProfilePage({Key? key, required this.customer}) : super(key: key);
  
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> targets = <TargetFocus>[];

  GlobalKey key = GlobalKey();
  GlobalKey key1 = GlobalKey();
  GlobalKey key2 = GlobalKey();
  GlobalKey key3 = GlobalKey();
  GlobalKey key4 = GlobalKey();
  GlobalKey key5 = GlobalKey();
  GlobalKey key6 = GlobalKey();
  GlobalKey key7 = GlobalKey();

  void initTargets() {
    targets.clear();
    targets.add(
      TargetFocus(
        identify: "key",
        keyTarget: key,
        alignSkip: Alignment.lerp(Alignment.bottomLeft, Alignment.centerLeft, 0.12),
        paddingFocus: 0,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            padding: EdgeInsets.only(top: 300),
            builder: (context, controller) {
              return Container(
                margin: EdgeInsets.only(left: 20, right: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      translate('profile_page.help.picture'),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: "key1",
        keyTarget: key1,
        alignSkip: Alignment.lerp(Alignment.bottomLeft, Alignment.centerLeft, 0.12),
        shape: ShapeLightFocus.RRect,
        radius: 3,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            padding: EdgeInsets.only(top: 220),
            builder: (context, controller) {
              return Container(
                margin: EdgeInsets.only(left: 20, right: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      translate('profile_page.help.username'),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: "key2",
        keyTarget: key2,
        alignSkip: Alignment.lerp(Alignment.bottomLeft, Alignment.centerLeft, 0.12),
        shape: ShapeLightFocus.RRect,
        radius: 3,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            padding: EdgeInsets.only(top: 130),
            builder: (context, controller) {
              return Container(
                margin: EdgeInsets.only(left: 20, right: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      translate('profile_page.help.dark_mode'),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: "key3",
        keyTarget: key3,
        alignSkip: Alignment.lerp(Alignment.bottomLeft, Alignment.centerLeft, 0.12),
        shape: ShapeLightFocus.RRect,
        radius: 3,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            padding: EdgeInsets.only(top: 50),
            builder: (context, controller) {
              return Container(
                margin: EdgeInsets.only(left: 20, right: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      translate('profile_page.help.account_settings'),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: "key4",
        keyTarget: key4,
        alignSkip: Alignment.lerp(Alignment.bottomLeft, Alignment.centerLeft, 0.12),
        shape: ShapeLightFocus.RRect,
        radius: 3,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            padding: EdgeInsets.only(bottom: 100),
            builder: (context, controller) {
              return Container(
                margin: EdgeInsets.only(left: 20, right: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      translate('profile_page.help.notifications'),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: "key5",
        keyTarget: key5,
        alignSkip: Alignment.lerp(Alignment.bottomLeft, Alignment.centerLeft, 0.12),
        shape: ShapeLightFocus.RRect,
        radius: 3,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            padding: EdgeInsets.only(bottom: 140),
            builder: (context, controller) {
              return Container(
                margin: EdgeInsets.only(left: 20, right: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      translate('profile_page.help.logout'),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: "key6",
        keyTarget: key6,
        alignSkip: Alignment.lerp(Alignment.bottomLeft, Alignment.centerLeft, 0.12),
        shape: ShapeLightFocus.RRect,
        radius: 3,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            padding: EdgeInsets.only(bottom: 190),
            builder: (context, controller) {
              return Container(
                margin: EdgeInsets.only(left: 20, right: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      translate('profile_page.help.delete'),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: "key7",
        keyTarget: key7,
        alignSkip: Alignment.lerp(Alignment.bottomLeft, Alignment.centerLeft, 0.12),
        shape: ShapeLightFocus.RRect,
        radius: 3,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            padding: EdgeInsets.only(bottom: 240),
            builder: (context, controller) {
              return Container(
                margin: EdgeInsets.only(left: 20, right: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      translate('profile_page.help.contact'),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void showTutorial() {
    initTargets();
    tutorialCoachMark = TutorialCoachMark(
      context,
      targets: targets,
      colorShadow: Theme.of(context).backgroundColor,
      textSkip: translate('skip').toUpperCase(),
      opacityShadow: 0.95,
      onFinish: () {
        if (kDebugMode) {
          print("finish");
        }
      },
      onClickTarget: (target) {
        if (kDebugMode) {
          print('onClickTarget: $target');
        }
      },
      onClickTargetWithTapPosition: (target, tapDetails) {
        if (kDebugMode) {
          print("target: $target");
          print("clicked at position local: ${tapDetails.localPosition} - global: ${tapDetails.globalPosition}");
        }
      },
      onClickOverlay: (target) {
        if (kDebugMode) {
          print('onClickOverlay: $target');
        }
      },
      onSkip: () {
        if (kDebugMode) {
          print("skip");
        }
      },
    )..show();
  }

  showAlertDialog(BuildContext context) {
    CustomerService customerService = CustomerService();
    
    Widget cancelButton = TextButton(
      child: Text(translate('cancel').toUpperCase()),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget deleteButton = TextButton(
      child: Text(translate('profile_page.delete').toUpperCase()),
      onPressed:  () async {
        await customerService.deleteCustomer(
          widget.customer!.id);
        Settings.clearCache(); 
        Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(
        translate('profile_page.delete'),
        style: TextStyle(color: Colors.red)
      ),
      content: Text(translate('profile_page.delete_confirm')),
      actions: [
        cancelButton,
        deleteButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;
    changeLocale(context, localizationDelegate.currentLocale.languageCode);

    return Scaffold(
      //appBar: AppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Container(
        child: FittedBox(
          child: FloatingActionButton.extended(
            backgroundColor: Theme.of(context).backgroundColor,
            icon: Icon(
              Icons.help,
              color: Theme.of(context).primaryColor),
            label: Text(
              translate('help'),
              style: TextStyle(
                color: Theme.of(context).primaryColor
              ),
            ),
            onPressed: () {
              Future.delayed(Duration.zero, showTutorial);
            },
          ),
        ),
      ) ,
      body: ListView(
        padding: EdgeInsets.only(top: 100),
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            key: key,
            child: ProfileWidget(
              imagePath:
                  widget.customer!.profilePic,
              onClicked: () async {
                var route = MaterialPageRoute(
                  builder: (BuildContext context) => editProfilePage(
                    customer: widget.customer,
                  ),
                );
                Navigator.of(context).push(route);
              },
            ),
          ),
          const SizedBox(height: 24),
          Container(
            key: key1,
            child: buildName(widget.customer!.fullName, widget.customer!.email,
              (widget.customer!.customerName),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            key: key2,
            child: buildDarkMode(),
          ),
          SettingsGroup(
            title: translate('profile_page.configuration'), 
            children: <Widget> [
              const SizedBox(height: 8),
              Container(
                key: key3,
                child: buildSettings(),
              ),
              Container(
                key: key4,
                child: buildNotifications(),
              ),
              Container(
                key: key5,
                child: buildLogout(),
              ),
              Container(
                key: key6,
                child: buildDeleteAccount(),
              ),
              Container(
                key: key7,
                child: buildContact(),
              ),
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

  Widget buildDarkMode() => SwitchSettingsTile(
    settingKey: ProfilePage.keyDarkMode,
    leading: IconWidget(
      icon: Icons.dark_mode,
      color: Color(0xFF642ef3),
    ),
    title: translate('profile_page.dark_mode'),
    onChange: (isDarkMode) { /* NOOP */}
  );

  Widget buildSettings() => SimpleSettingsTile(
    leading: IconWidget(
      color: Colors.green, 
      icon: Icons.person
    ),
    title: translate('profile_page.account_settings.title'),
    subtitle: translate('profile_page.account_settings.sub_title'),
    //child: Container(),
    onTap: () { 
      Navigator.push(context, MaterialPageRoute(builder: (context) => AccountPage()));
    },
  );

  Widget buildNotifications() => SimpleSettingsTile(
    leading: IconWidget(
      color: Colors.orangeAccent, 
      icon: Icons.notifications
    ),
    title: translate('profile_page.notifications'),
    subtitle: '',
    //child: Container(),
    onTap: () { 
      //
    },
  );

  Widget buildLogout() => SimpleSettingsTile(
    leading: IconWidget(
      color: Colors.blueAccent, 
      icon: Icons.logout
    ),
    title: translate('profile_page.logout'),
    subtitle: '',
    onTap: () { 
      Settings.clearCache();
      Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
    },
  );

  Widget buildDeleteAccount() => SimpleSettingsTile(
    leading: IconWidget(
      color: Colors.redAccent, 
      icon: Icons.delete
    ),
    title: translate('profile_page.delete'),
    subtitle: '',
    onTap: () { 
      showAlertDialog(context);
    },
  );

  Widget buildContact() => SimpleSettingsTile(
    leading: IconWidget(
      color: Color.fromARGB(255, 231, 100, 0), 
      icon: Icons.mail_outline,
    ),
    title: translate('profile_page.contact.title'),
    subtitle: translate('profile_page.contact.sub_title'),
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => EmailPage()));
    },
  );

}