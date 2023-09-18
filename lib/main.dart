import 'package:demo_sih7/LandingPage/landingPage.dart';
import 'package:flutter/material.dart';
import 'Screens/theme.dart';
import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  runApp(MaterialApp(
    title: 'Flutter Demo',
    debugShowCheckedModeBanner: false,
    theme: Themes.lightTheme,
    home: MyLandingPage(
      firstCam: firstCamera,
    ),
  ));
}
