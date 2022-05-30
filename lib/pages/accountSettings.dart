import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_tutorial/widgets/iconWidget.dart';

class AccountPage extends StatefulWidget {
  AccountPage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _AccountPage createState() => _AccountPage();
}

class _AccountPage extends State<AccountPage> {
  static const keyLanguage = 'key-language';

  @override
  Widget build(BuildContext context) {
    //var localizationDelegate = LocalizedApp.of(context).delegate;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(translate('app_bar.title')),
        backgroundColor: Theme.of(context).cardColor,
        ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildLanguage(context: context),
          ],
        ),
      ),
    );
  }

  Widget buildLanguage({required BuildContext context}) => DropDownSettingsTile(
    settingKey: keyLanguage,
    title: translate('language.title'),
    selected: 1,
    values: <int, String> {
      1: translate('language.name.en'),
      2: translate('language.name.es'),
      3: translate('language.name.ca'),
    },
    onChange: (language) {
      if(language == 1) changeLocale(context, 'en');
      if(language == 2) changeLocale(context, 'es');
      if(language == 3) changeLocale(context, 'ca');
    },
  );
}
