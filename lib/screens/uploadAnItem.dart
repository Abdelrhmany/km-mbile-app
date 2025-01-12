import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadScreen extends StatefulWidget {
  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final ImagePicker _picker = ImagePicker();
  List<File> _images = [];
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  String _price = '';
  String _location = '';
  String _category = '';
  String _condition = '';

  // الحقول الإضافية لبيانات السيارات
  String? _brand;
  String? _modelYear;
  String? _km;
  String? _engineCC;
  String? _fuelType;
  String? _transmission;
  String? _drivetrain;
  String? _doors;

  final Map<String, String> _categories = {
    'Cars': 'سيارات',
    'Property': 'عقارات',
    'Services': 'خدمات',
    'Furniture': 'أثاث',
    'Camping': 'تخييم',
    'Gifts': 'هدايا',
    'Contracting': 'مقاولات',
    'Family': 'عائلة',
    'Animals': 'حيوانات',
    'Electronics': 'إلكترونيات',
    'Clothing': 'ملابس',
  };

  Future<void> pickImages() async {
    final pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        _images = pickedFiles.map((file) => File(file.path)).toList();
      });
    }
  }

  Future<void> uploadData() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? userData = prefs.getStringList('userdata');

    if (userData == null || userData.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('بيانات المستخدم غير متوفرة')),
      );
      return;
    }

    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    if (_images.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('يرجى اختيار صورة واحدة على الأقل')),
      );
      return;
    }

    final uri = Uri.parse('https://kwtmarkets.net/back/items');
    final request = http.MultipartRequest('POST', uri);

    for (var image in _images) {
      if (await image.exists()) {
        request.files
            .add(await http.MultipartFile.fromPath('images', image.path));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('هناك مشكلة في الصور المختارة')),
        );
        return;
      }
    }

    request.fields['title'] = _title;
    request.fields['description'] = _description;
    request.fields['price'] = _price;
    request.fields['location'] = _location;
    request.fields['category'] = _category;
    request.fields['condition'] = _condition;
    request.fields['sellerid'] = userData[0];
    request.fields['sellername'] = userData[1];

    if (_category == 'Cars') {
      request.fields['brand'] = _brand ?? '';
      request.fields['modelYear'] = _modelYear ?? '';
      request.fields['km'] = _km ?? '';
      request.fields['engineCC'] = _engineCC ?? '';
      request.fields['fuelType'] = _fuelType ?? '';
      request.fields['transmission'] = _transmission ?? '';
      request.fields['drivetrain'] = _drivetrain ?? '';
      request.fields['doors'] = _doors ?? '';
    }

    try {
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('تم رفع البيانات بنجاح!')),
        );
      } else {
        print('Response: $responseBody');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('فشل رفع البيانات: $responseBody')),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ أثناء الرفع.')),
      );
    }
  }

  void showCarDetailsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('إدخال بيانات السيارة', style: GoogleFonts.cairo()),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'العلامة التجارية'),
                  onChanged: (value) => _brand = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'سنة التصنيع'),
                  onChanged: (value) => _modelYear = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'عدد الكيلومترات'),
                  onChanged: (value) => _km = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'حجم المحرك'),
                  onChanged: (value) => _engineCC = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'نوع الوقود'),
                  onChanged: (value) => _fuelType = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'ناقل الحركة'),
                  onChanged: (value) => _transmission = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'نظام الدفع'),
                  onChanged: (value) => _drivetrain = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'عدد الأبواب'),
                  onChanged: (value) => _doors = value,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('حفظ', style: GoogleFonts.cairo()),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('رفع عنصر', style: GoogleFonts.cairo()),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'العنوان'),
                  validator: (value) =>
                      value!.isEmpty ? 'يرجى إدخال العنوان' : null,
                  onSaved: (value) => _title = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'الوصف'),
                  validator: (value) =>
                      value!.isEmpty ? 'يرجى إدخال الوصف' : null,
                  onSaved: (value) => _description = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'السعر'),
                  validator: (value) =>
                      value!.isEmpty ? 'يرجى إدخال السعر' : null,
                  onSaved: (value) => _price = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'الموقع'),
                  validator: (value) =>
                      value!.isEmpty ? 'يرجى إدخال الموقع' : null,
                  onSaved: (value) => _location = value!,
                ),
                DropdownButtonFormField<String>(
                  value: _category.isNotEmpty ? _category : null,
                  items: _categories.entries.map((entry) {
                    return DropdownMenuItem<String>(
                      value: entry.key,
                      child: Text(entry.value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _category = value!;
                      if (_category == 'Cars') showCarDetailsDialog();
                    });
                  },
                  decoration: InputDecoration(labelText: 'الفئة'),
                  validator: (value) =>
                      value == null ? 'يرجى اختيار الفئة' : null,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'الحالة'),
                  validator: (value) =>
                      value!.isEmpty ? 'يرجى إدخال الحالة' : null,
                  onSaved: (value) => _condition = value!,
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: pickImages,
                  child: Text('اختيار الصور'),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: uploadData,
                  child: Text('رفع العنصر'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../sevices/shared.dart';

// class UploadScreen extends StatefulWidget {
//   @override
//   _UploadScreenState createState() => _UploadScreenState();
// }

// class _UploadScreenState extends State<UploadScreen> {
//   final ImagePicker _picker = ImagePicker();
//   List<File> _images = [];
//   final _formKey = GlobalKey<FormState>();
//   String _title = '';
//   String _description = '';
//   String _price = '';
//   String _location = '';
//   String _category = '';
//   String _condition = '';

//   // قائمة الفئات بالعربية
//   final Map<String, String> _categories = {
//     'Cars': 'سيارات',
//     'Property': 'عقارات',
//     'Services': 'خدمات',
//     'Furniture': 'أثاث',
//     'Camping': 'تخييم',
//     'Gifts': 'هدايا',
//     'Contracting': 'مقاولات',
//     'Family': 'عائلة',
//     'Animals': 'حيوانات',
//     'Electronics': 'إلكترونيات',
//     'Clothing': 'ملابس',
//   };

//   // اختيار الصور
//   Future<void> pickImages() async {
//     final pickedFiles = await _picker.pickMultiImage();
//     if (pickedFiles != null) {
//       setState(() {
//         _images = pickedFiles.map((file) => File(file.path)).toList();
//       });
//     }
//   }

//   // رفع البيانات والصور
//   Future<void> uploadData() async {
//     final prefs = await SharedPreferences.getInstance();
//     List<String>? x = await prefs.getStringList('userdata');

//     if (x == null || x.length < 2) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('بيانات المستخدم غير متوفرة')),
//       );
//       return;
//     }

//     if (!_formKey.currentState!.validate()) return;
//     _formKey.currentState!.save();

//     if (_images.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('يرجى اختيار صورة واحدة على الأقل')),
//       );
//       return;
//     }

//     final uri = Uri.parse('https://kwtmarkets.net/back/items');
//     final request = http.MultipartRequest('POST', uri);

//     for (var image in _images) {
//       if (await image.exists()) {
//         request.files
//             .add(await http.MultipartFile.fromPath('images', image.path));
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('هناك مشكلة في الصور المختارة')),
//         );
//         return;
//       }
//     }

//     request.fields['title'] = _title;
//     request.fields['description'] = _description;
//     request.fields['price'] = _price;
//     request.fields['location'] = _location;
//     request.fields['category'] = _category;
//     request.fields['condition'] = _condition;
//     request.fields['sellerid'] = x[0];
//     request.fields['sellername'] = x[1];

//     try {
//       final response = await request.send();
//       final responseBody = await response.stream.bytesToString();
//       if (response.statusCode == 201) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('تم رفع البيانات بنجاح!')),
//         );
//       } else {
//         print('Response: $responseBody');
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('فشل رفع البيانات: $responseBody')),
//         );
//       }
//     } catch (e) {
//       print('Error: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('حدث خطأ أثناء الرفع.')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           centerTitle: true,
//           title: Text(
//             'رفع عنصر',
//             style: GoogleFonts.cairo(),
//           ),
//           backgroundColor: Color.fromRGBO(255, 58, 58, 1)),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const SizedBox(height: 20),
//                 TextFormField(
//                   decoration: InputDecoration(
//                     labelText: 'العنوان',
//                     labelStyle: GoogleFonts.cairo(
//                       color: Color.fromRGBO(65, 65, 65, 1),
//                     ),
//                     border: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.grey, width: 2),
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                   ),
//                   validator: (value) =>
//                       value!.isEmpty ? 'يرجى إدخال العنوان' : null,
//                   onSaved: (value) => _title = value!,
//                   textAlign: TextAlign.center,
//                 ),
//                 SizedBox(height: 10),
//                 TextFormField(
//                   decoration: InputDecoration(
//                     labelText: 'الوصف',
//                     labelStyle: GoogleFonts.cairo(
//                       color: Color.fromRGBO(65, 65, 65, 1),
//                     ),
//                     border: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.grey, width: 2),
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                   ),
//                   validator: (value) =>
//                       value!.isEmpty ? 'يرجى إدخال الوصف' : null,
//                   onSaved: (value) => _description = value!,
//                   textAlign: TextAlign.center,
//                 ),
//                 SizedBox(height: 10),
//                 TextFormField(
//                   decoration: InputDecoration(
//                     labelText: 'السعر',
//                     labelStyle: GoogleFonts.cairo(
//                       color: Color.fromRGBO(65, 65, 65, 1),
//                     ),
//                     border: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.grey, width: 2),
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                   ),
//                   keyboardType: TextInputType.number,
//                   validator: (value) =>
//                       value!.isEmpty ? 'يرجى إدخال السعر' : null,
//                   onSaved: (value) => _price = value!,
//                   textAlign: TextAlign.center,
//                 ),
//                 SizedBox(height: 10),
//                 TextFormField(
//                   decoration: InputDecoration(
//                     labelText: 'الموقع',
//                     labelStyle: GoogleFonts.cairo(
//                       color: Color.fromRGBO(65, 65, 65, 1),
//                     ),
//                     border: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.grey, width: 2),
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                   ),
//                   validator: (value) =>
//                       value!.isEmpty ? 'يرجى إدخال الموقع' : null,
//                   onSaved: (value) => _location = value!,
//                   textAlign: TextAlign.center,
//                 ),
//                 SizedBox(height: 10),
//                 DropdownButtonFormField<String>(
//                   decoration: InputDecoration(
//                     labelText: 'الفئة',
//                     labelStyle: GoogleFonts.cairo(
//                       color: Color.fromRGBO(65, 65, 65, 1),
//                     ),
//                     border: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.grey, width: 2),
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                   ),
//                   value: _category.isNotEmpty ? _category : null,
//                   items: _categories.entries.map((entry) {
//                     return DropdownMenuItem<String>(
//                       value: entry.key,
//                       child: Text(entry.value, style: GoogleFonts.cairo()),
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       _category = value!;
//                     });
//                   },
//                   validator: (value) =>
//                       value == null ? 'يرجى اختيار الفئة' : null,
//                 ),
//                 SizedBox(height: 10),
//                 TextFormField(
//                   decoration: InputDecoration(
//                     labelText: 'الحالة',
//                     labelStyle: GoogleFonts.cairo(
//                       color: Color.fromRGBO(65, 65, 65, 1),
//                     ),
//                     border: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.grey, width: 2),
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                   ),
//                   validator: (value) =>
//                       value!.isEmpty ? 'يرجى إدخال الحالة' : null,
//                   onSaved: (value) => _condition = value!,
//                   textAlign: TextAlign.center,
//                 ),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: pickImages,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color.fromRGBO(255, 58, 58, 1),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                   ),
//                   child: Text(
//                     'اختيار الصور',
//                     style: GoogleFonts.cairo(color: Colors.white),
//                   ),
//                 ),
//                 _images.isNotEmpty
//                     ? Wrap(
//                         children: _images
//                             .map((image) => Image.file(
//                                   image,
//                                   width: 100,
//                                   height: 100,
//                                   fit: BoxFit.cover,
//                                 ))
//                             .toList(),
//                       )
//                     : Text(
//                         'لم يتم اختيار أي صور',
//                         style: GoogleFonts.cairo(color: Colors.grey),
//                       ),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () async {
//                     await uploadData().then((f) {
//                       print('x');
//                     });
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color.fromRGBO(255, 58, 58, 1),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                   ),
//                   child: Text(
//                     'رفع البيانات',
//                     style: GoogleFonts.cairo(color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
