import 'package:flutter/material.dart';

class Themes {
  static final light = ThemeData.light().copyWith(
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black26,
      showUnselectedLabels: false,
      showSelectedLabels: false,
    ),
    appBarTheme: const AppBarTheme(backgroundColor:Color(0xff0ce388) ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(const Color(0xff0ce388))),
    ),
    primaryColor: const Color(0xff0ce388),
    primaryColorLight: const Color(0xffdde8e4),
    primaryTextTheme: TextTheme()
    
  );

  static final dark = ThemeData.dark().copyWith(

    textTheme: TextTheme(displayMedium  : TextStyle(backgroundColor: const Color(
        0xff000000),)),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: Color(0xffdde8e4),
    unselectedItemColor: Colors.white24,
    showUnselectedLabels: false,
    showSelectedLabels: false,
  ),
  );
}
