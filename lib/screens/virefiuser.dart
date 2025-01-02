import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VerifyScreen extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  Future<String> verifyUser(String phoneNumber, String verificationCode) async {
    final url = Uri.parse('https://kwtmarkets.net/back/verify');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'phoneNumber': phoneNumber,
      'verificationCode': verificationCode,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        return 'User verified successfully';
      } else {
        return 'Invalid verification code';
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
        ' التحقق',
        style: GoogleFonts.cairo(
          fontSize: 22,
          color: Colors.black,
        ),
      )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                hintText: ' رقم الهاتف',
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
              height: 10,
            ),
            TextField(
              controller: codeController,
              decoration: InputDecoration(
                hintText: ' رمز التحقق',
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final result = await verifyUser(
                  phoneController.text,
                  codeController.text,
                );
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
                'تحقق ',
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
