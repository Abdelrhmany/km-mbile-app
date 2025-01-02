import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UpdatePasswordScreen extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  Future<String> updatePassword(
      String phoneNumber, String verificationCode, String newPassword) async {
    final url = Uri.parse('https://kwtmarkets.net/back/update-password');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'phoneNumber': phoneNumber,
      'verificationCode': verificationCode,
      'newPassword': newPassword,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        return 'Password updated successfully';
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
        'تغيير كلمة السر',
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
              height: 20,
            ),
            TextField(
              controller: codeController,
              decoration: InputDecoration(
                hintText: ' كود التحقق ',
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
              controller: newPasswordController,
              decoration: InputDecoration(
                hintText: ' كلمة السر الجديدة',
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
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final result = await updatePassword(
                  phoneController.text,
                  codeController.text,
                  newPasswordController.text,
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(result)),
                );
              },
              child: Text('Update Password'),
            ),
          ],
        ),
      ),
    );
  }
}
