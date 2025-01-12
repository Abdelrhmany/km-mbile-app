import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> loginUser(String phoneNumber, String password) async {
  final url = Uri.parse('https://kwtmarkets.net/back/login');
  final headers = {'Content-Type': 'application/json'};

  final body = jsonEncode({
    'phoneNumber': phoneNumber,
    'password': password,
  });

  try {
    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      return response.body; // نجاح
    } else {
      return 'Login failed: ${response.body}'; // فشل
    }
  } catch (e) {
    return 'Error: $e'; // خطأ أثناء التنفيذ
  }
}
