import 'package:demo_sih7/LandingPage/landingPage.dart';
import 'package:flutter/material.dart';
import 'Screens/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: Themes.lightTheme,
      home: MyLandingPage(),
    );
  }
}
