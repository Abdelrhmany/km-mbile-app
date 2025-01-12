import 'package:shared_preferences/shared_preferences.dart';

class Sharedd {
  void loadUserData() async {
    final prefs = await SharedPreferences.getInstance();

    // قراءة البيانات
    List<String>? userData = prefs.getStringList('userdata');

    if (userData != null) {
      // البيانات موجودة
      String phoneNumber = userData[0]; // رقم الهاتف
      String value = userData[1]; // القيمة الأخرى

      print('Phone Number: $phoneNumber');
      print('Value: $value');
    } else {
      // البيانات غير موجودة
      print('No user data found!');
    }
  }
}
