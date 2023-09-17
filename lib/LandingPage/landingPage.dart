import 'package:demo_sih7/Screens/Home/homeScreen.dart';
import 'package:demo_sih7/Screens/Reports/reportScreen.dart';
import 'package:demo_sih7/Screens/Service/serviceScreen.dart';
import 'package:demo_sih7/Screens/Upload/uploadScreen.dart';
import 'package:demo_sih7/Screens/You/youScreen.dart';
import 'package:flutter/material.dart';

class MyLandingPage extends StatefulWidget {
  const MyLandingPage({super.key});

  @override
  State<MyLandingPage> createState() => _MyLandingPageState();
}

class _MyLandingPageState extends State<MyLandingPage> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    HomeScreen(),
    ReportScreen(),
    UploadScreen(),
    ServiceScreen(),
    YouScreen(),
  ];
  final List<String> _titleName = [
    "Home",
    "Reports & Diagnosis",
    "Upload ",
    "Services & More",
    "My Profile"
  ];

  static List<BottomNavigationBarItem> getBottomNavBarItem() {
    return const [
      BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
        ),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.checklist_sharp),
        label: 'Diagnosis',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.photo_camera_rounded),
        label: 'Upload',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.grid_view_rounded),
        label: 'Service',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'You',
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    double scrHeight = MediaQuery.of(context).size.height;
    double scrWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              print("test menu iconButton");
            },
            icon: const Icon(Icons.menu)),
        title: Text(_titleName[_currentIndex]),
        actions: [
          IconButton(
              onPressed: () {
                print("test notifs iconButton");
              },
              icon: const Icon(Icons.notifications))
        ],
      ),
      body: Container(
          height: scrHeight, width: scrWidth, child: _children[_currentIndex]),
      bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.lightBlueAccent),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (int index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: getBottomNavBarItem(),
            fixedColor: Color.fromARGB(255, 244, 111, 16),
            iconSize: 26,
            selectedFontSize: 18,
            selectedIconTheme: const IconThemeData(size: 30),
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
          )),
    );
  }
}
