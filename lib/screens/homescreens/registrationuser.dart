import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernamecontroler = TextEditingController();

  Future<String> registerUser(
      String phoneNumber, String password, String username) async {
    final url = Uri.parse('https://kwtmarkets.net/back/register');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'phoneNumber': phoneNumber,
      'password': password,
      'username': username,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        return 'Verification code has been sent successfully';
      } else {
        return 'Error: ${response.body}';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'تسجيل جديد',
        style: GoogleFonts.cairo(
          fontSize: 22,
          color: Colors.black,
        ),
      )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            TextField(
              controller: phoneController,
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
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: passwordController,
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
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: usernamecontroler,
              decoration: InputDecoration(
                hintText: ' اسم المستخدم',
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
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () async {
                final result = await registerUser(phoneController.text,
                    passwordController.text, usernamecontroler.text);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(result)),
                );
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
                'تسجيل ',
                style: GoogleFonts.cairo(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
