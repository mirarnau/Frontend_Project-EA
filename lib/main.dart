// ignore_for_file: unnecessary_const, prefer_const_constructors


import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_tutorial/pages/loginPage.dart';
import 'package:flutter_tutorial/pages/profilePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  await Settings.init(cacheProvider: SharePreferenceCache());

  var delegate = await LocalizationDelegate.create(
    fallbackLocale: 'en',
    supportedLocales: ['en', 'es', 'ca']);

    runApp(LocalizedApp(delegate, MyApp()));

}


//MyApp is the root widget
class MyApp extends StatelessWidget {
  //The fact that it's a statless widget ENABLES HOT RELOAD

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var localizationDelegate = LocalizedApp.of(context).delegate;

    return LocalizationProvider(
      //MaterialApp is another widget, and it allows us to make the designs, it acts as a wrapper for the other widgets.
      state: LocalizationProvider.of(context).state,
      child: ValueChangeObserver<bool>(
        cacheKey: ProfilePage.keyDarkMode,
        defaultValue: false,
        builder: (_, isDarkMode, __) => MaterialApp(
          title: 'Appétit',
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            localizationDelegate
          ],
          supportedLocales: localizationDelegate.supportedLocales,
          locale: localizationDelegate.currentLocale,
          theme: isDarkMode 
            ? ThemeData.dark().copyWith(
              primaryColor: Color.fromARGB(255, 213, 94, 85),
              scaffoldBackgroundColor: Color.fromARGB(255, 16, 16, 16),
              canvasColor: Color.fromARGB(255, 30, 30, 30),
              backgroundColor: const Color.fromARGB(255, 48, 48, 48),
              cardColor:Color.fromARGB(255, 56, 55, 55),
              focusColor: Color.fromARGB(255, 213, 94, 85),
              indicatorColor: Colors.white,
              shadowColor: Color.fromARGB(255, 104, 104, 104),
              hoverColor: Color.fromARGB(255, 96, 66, 64),
              highlightColor: Colors.white,
              hintColor: Color.fromARGB(255, 56, 55, 55),
              dialogBackgroundColor: Color.fromARGB(255, 226, 226, 226),
              dialogTheme: DialogTheme(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)
                ),
              )
            )
            : ThemeData.light().copyWith(
              primaryColor: Color.fromARGB(255, 233, 166, 66),
              scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
              canvasColor: Color.fromARGB(255, 255, 255, 255),
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
              cardColor:Color.fromARGB(255, 233, 166, 66),
              focusColor: Color.fromARGB(255, 255, 255, 255),
              indicatorColor: Color.fromARGB(255, 217, 105, 105),
              shadowColor: Color.fromARGB(255, 170, 170, 170),
              hoverColor: Color.fromARGB(255, 253, 225, 187),
              highlightColor: Colors.black,
              hintColor: Color.fromARGB(255, 219, 219, 219),
              dialogBackgroundColor: Color.fromARGB(255, 31, 31, 31),
              dialogTheme: DialogTheme(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)
                ),
              )
            ),
          
          home: LoginPage()
        ),
      ),
    );
  }
}

class Palette { 
  static const MaterialColor kToDark = const MaterialColor( 
    0xff2B2B2B,// 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch. 
    const <int, Color>{ 
      50: const Color(0xff4c4b4b),//10% 
      100: const Color(0x00444444),//20% 
      200: const Color(0xffa04332),//30% 
      300: const Color(0xff89392b),//40% 
      400: const Color(0xff733024),//50% 
      500: const Color(0xff5c261d),//60% 
      600: const Color(0xff451c16),//70% 
      700: const Color(0xff2e130e),//80% 
      800: const Color(0xff170907),//90% 
      900: const Color(0xff000000),//100% 
    }, 
  ); 
}
