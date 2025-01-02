import 'package:flutter/material.dart';
import 'dart:async';

import 'package:xyz/screens/intro.dart';

class SplashScreent extends StatefulWidget {
  const SplashScreent({super.key});

  @override
  State<SplashScreent> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreent> {
  @override
  void initState() {
    super.initState();
    // الانتقال بعد 3 ثوانٍ
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const Homescrren()), // ضع الصفحة التالية هنا
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Image.asset('assets/logo.png'),
        ),
      ),
    );
  }
}
