import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:xyz/screens/aplashscreen.dart';
import 'package:xyz/screens/homescreens/firsthome.dart';
import 'package:xyz/screens/uploadAnItem.dart';

import 'sevices/global_data.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding
      .ensureInitialized(); // لتشغيل دالة async قبل بناء الواجهة
  await fetchDataFromAPI();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: UploadScreen()
        // SplashScreen(), // الشاشة الأولى
        );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // قائمة الشاشات
  final List<Widget> _screens = [
    UploadScreen(),
    const Firsthome(), // الشاشة الأولى

    const Center(child: Text('Third Screen', style: TextStyle(fontSize: 24))),
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
