import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:xyz/main.dart';
import 'package:xyz/sevices/login.dart';

import 'homescreens/registrationuser.dart';
import 'resetpassword.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Image.asset(
              'assets/logg.png',
              height: 200,
              width: 200,
            ),

            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'رقم الهاتف',
                hintStyle: GoogleFonts.cairo(
                  color: Color.fromRGBO(135, 135, 135, 1),
                ),
                filled: true,
                fillColor: const Color.fromRGBO(253, 253, 253, 1),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red, width: 2),
                  borderRadius: BorderRadius.circular(25),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(25),
                ),
                contentPadding: const EdgeInsets.all(12),
              ),
            ),
            const SizedBox(height: 15),

            // حقل كلمة السر
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'كلمة السر',
                hintStyle: GoogleFonts.cairo(
                  color: Color.fromRGBO(135, 135, 135, 1),
                ),
                filled: true,
                fillColor: const Color.fromRGBO(253, 253, 253, 1),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red, width: 2),
                  borderRadius: BorderRadius.circular(25),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(25),
                ),
                contentPadding: const EdgeInsets.all(12),
              ),
            ),
            const SizedBox(height: 20),

            // زر تسجيل الدخول
            ElevatedButton(
              onPressed: () async {
                final result = await loginUser(
                  _phoneController.text,
                  _passwordController.text,
                );

                if (result == 'Login successful') {
                  print('تم تسجيل الدخول بنجاح');
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                } else {
                  // عرض رسالة خطأ
                  print(result);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(result)),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(255, 58, 58, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
              ),
              child: Text(
                'تسجيل الدخول',
                style: GoogleFonts.cairo(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // روابط تسجيل جديد ونسيت كلمة السر
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => RegisterScreen()));
                  },
                  child: Text(
                    'تسجيل جديد',
                    style: GoogleFonts.cairo(
                      fontSize: 14,
                      color: const Color.fromRGBO(255, 58, 58, 1),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => ResetPasswordScreen()));
                    // هنا يمكن إضافة عملية الانتقال إلى صفحة استعادة كلمة السر
                    print("هل نسيت كلمة السر؟");
                  },
                  child: Text(
                    'هل نسيت كلمة السر؟',
                    style: GoogleFonts.cairo(
                      fontSize: 14,
                      color: const Color.fromRGBO(65, 65, 65, 1),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
