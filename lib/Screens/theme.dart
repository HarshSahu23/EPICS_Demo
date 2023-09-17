import 'package:flutter/material.dart';

class Themes {
  Themes._();
  static const Color bluishClr = Color(0xFF4e5ae8);
  static const Color yellowClr = Color(0xFFFFB746);
  static const Color pinkClr = Color(0xFFff4667);
  static const Color greenClr = Color.fromARGB(255, 39, 185, 3);
  static const Color white = Colors.white;
  static const Color darkGreyClr = Color(0xFF121212);
  static const Color darkHeaderClr = Color(0xFF424242);

  static const Color primaryClr = Color(0xFF4e5ae8);
  static const Color dialColorScheme = darkHeaderClr;

  static final ThemeData lightTheme = ThemeData(
    backgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
        color: white,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20)),
    colorScheme: const ColorScheme.light(
        primary: primaryClr,
        onPrimary: Colors.white,
        brightness: Brightness.light,
        inversePrimary: darkHeaderClr,
        background: Colors.white),
  );
}
