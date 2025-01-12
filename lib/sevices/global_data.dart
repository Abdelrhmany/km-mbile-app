import 'dart:convert';

import 'package:http/http.dart' as http;

// المتغير العام لتخزين البيانات
List globalData = [];

// دالة لجلب البيانات من API
Future<void> fetchDataFromAPI() async {
  try {
    final response = await http.get(
      Uri.parse('https://kwtmarkets.net/back/items?status=act'),
    );
    if (response.statusCode == 200) {
      globalData =
          json.decode(response.body); // تخزين البيانات في المتغير العام
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    print('Error fetching data: $e');
  }
}
