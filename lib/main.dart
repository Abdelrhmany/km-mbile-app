import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:xyz/screens/aplashscreen.dart';
import 'package:xyz/screens/homescreens/firsthome.dart';
import 'package:xyz/screens/uploadAnItem.dart';
//+201062394355
import 'sevices/global_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'userinfo.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding
      .ensureInitialized(); // لتشغيل دالة async قبل بناء الواجهة
  await fetchDataFromAPI();
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, home: SplashScreen(), // الشاشة الأولى
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  ////////
  // قائمة الشاشات
  final List<Widget> _screens = [
    UploadScreen(),
    const Firsthome(), // الشاشة الأولى

    UserProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex], // عرض الشاشة الحالية
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent, // لون خلفية الشاشة
        color: Colors.white,
        buttonBackgroundColor:
            const Color.fromRGBO(255, 58, 58, 1), // لون زر التنقل الحالي
        height: 60, // ارتفاع الشريط
        items: const <Widget>[
          Icon(Icons.add, size: 30, color: Colors.black),
          Icon(Icons.home, size: 30, color: Colors.black),
          Icon(Icons.account_box_sharp, size: 30, color: Colors.black),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index; // تغيير الشاشة الحالية عند الضغط
          });
        },
      ),
    );
  }
}
