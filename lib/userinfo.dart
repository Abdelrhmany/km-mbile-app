import 'package:flutter/material.dart';
import 'package:xyz/screens/login.dart';
import 'package:xyz/sevices/login.dart';

import 'screens/LoginPage.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  void logout() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("الملف الشخصي"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text("الاسم"),
              subtitle: Text(''),
            ),
            ListTile(
              title: Text("رقم الموبايل"),
              subtitle: Text(''),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: logout,
              child: Text("تسجيل الخروج"),
            ),
          ],
        ),
      ),
    );
  }
}
