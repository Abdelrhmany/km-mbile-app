import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';

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

  // قائمة الفئات بالعربية
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

  // اختيار الصور
  Future<void> pickImages() async {
    final pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        _images = pickedFiles.map((file) => File(file.path)).toList();
      });
    }
  }

  // رفع البيانات والصور
  Future<void> uploadData() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    // التحقق من وجود صورة واحدة على الأقل
    if (_images.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('يرجى اختيار صورة واحدة على الأقل')),
      );
      return;
    }

    final uri = Uri.parse('https://backend.kwtmarkets.com/items');
    final request = http.MultipartRequest('POST', uri);

    // إضافة الصور
    for (var image in _images) {
      request.files
          .add(await http.MultipartFile.fromPath('images', image.path));
    }

    // إضافة البيانات
    request.fields['title'] = _title;
    request.fields['description'] = _description;
    request.fields['price'] = _price;
    request.fields['location'] = _location;
    request.fields['category'] = _category;
    request.fields['condition'] = _condition;

    try {
      final response = await request.send();
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('تم رفع البيانات بنجاح!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('فشل رفع البيانات.')),
        );
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ أثناء الرفع.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'رفع عنصر',
          style: GoogleFonts.cairo(),
        ),
        backgroundColor: Color.fromRGBO(255, 58, 58, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'العنوان',
                    labelStyle: GoogleFonts.cairo(
                      color: Color.fromRGBO(65, 65, 65, 1),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'يرجى إدخال العنوان' : null,
                  onSaved: (value) => _title = value!,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'الوصف',
                    labelStyle: GoogleFonts.cairo(
                      color: Color.fromRGBO(65, 65, 65, 1),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'يرجى إدخال الوصف' : null,
                  onSaved: (value) => _description = value!,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'السعر',
                    labelStyle: GoogleFonts.cairo(
                      color: Color.fromRGBO(65, 65, 65, 1),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value!.isEmpty ? 'يرجى إدخال السعر' : null,
                  onSaved: (value) => _price = value!,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'الموقع',
                    labelStyle: GoogleFonts.cairo(
                      color: Color.fromRGBO(65, 65, 65, 1),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'يرجى إدخال الموقع' : null,
                  onSaved: (value) => _location = value!,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'الفئة',
                    labelStyle: GoogleFonts.cairo(
                      color: Color.fromRGBO(65, 65, 65, 1),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  value: _category.isNotEmpty ? _category : null,
                  items: _categories.entries.map((entry) {
                    return DropdownMenuItem<String>(
                      value: entry.key,
                      child: Text(entry.value, style: GoogleFonts.cairo()),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _category = value!;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'يرجى اختيار الفئة' : null,
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'الحالة',
                    labelStyle: GoogleFonts.cairo(
                      color: Color.fromRGBO(65, 65, 65, 1),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'يرجى إدخال الحالة' : null,
                  onSaved: (value) => _condition = value!,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: pickImages,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(255, 58, 58, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(
                    'اختيار الصور',
                    style: GoogleFonts.cairo(color: Colors.white),
                  ),
                ),
                _images.isNotEmpty
                    ? Wrap(
                        children: _images
                            .map((image) => Image.file(
                                  image,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ))
                            .toList(),
                      )
                    : Text(
                        'لم يتم اختيار أي صور',
                        style: GoogleFonts.cairo(color: Colors.grey),
                      ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: uploadData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(255, 58, 58, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(
                    'رفع البيانات',
                    style: GoogleFonts.cairo(color: Colors.white),
                  ),
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
//     if (!_formKey.currentState!.validate()) return;
//     _formKey.currentState!.save();

//     final uri = Uri.parse(
//         'https://backend.kwtmarkets.com/items'); // ضع رابط الـ API هنا
//     final request = http.MultipartRequest('POST', uri);

//     // إضافة الصور
//     for (var image in _images) {
//       request.files.add(await http.MultipartFile.fromPath(
//         'images', // اسم الحقل في الباك اند
//         image.path,
//       ));
//     }

//     // إضافة البيانات
//     request.fields['title'] = _title;
//     request.fields['description'] = _description;
//     request.fields['price'] = _price;
//     request.fields['location'] = _location;
//     request.fields['category'] = _category;
//     request.fields['condition'] = _condition;

//     try {
//       final response = await request.send();
//       if (response.statusCode == 201) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('تم رفع البيانات بنجاح!')),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('فشل رفع البيانات.')),
//         );
//       }
//     } catch (e) {
//       print(e);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('حدث خطأ أثناء الرفع.')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           'رفع عنصر',
//           style: GoogleFonts.cairo(),
//         ),
//         backgroundColor: Color.fromRGBO(255, 58, 58, 1), // اللون الأحمر
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const SizedBox(
//                   height: 20,
//                 ),
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
//                   textAlign: TextAlign.center, // محاذاة النص في المنتصف
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
//                   textAlign: TextAlign.center, // محاذاة النص في المنتصف
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
//                   textAlign: TextAlign.center, // محاذاة النص في المنتصف
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
//                   textAlign: TextAlign.center, // محاذاة النص في المنتصف
//                 ),
//                 SizedBox(height: 10),
//                 TextFormField(
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
//                   validator: (value) =>
//                       value!.isEmpty ? 'يرجى إدخال الفئة' : null,
//                   onSaved: (value) => _category = value!,
//                   textAlign: TextAlign.center, // محاذاة النص في المنتصف
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
//                   textAlign: TextAlign.center, // محاذاة النص في المنتصف
//                 ),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: pickImages,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor:
//                         Color.fromRGBO(255, 58, 58, 1), // اللون الأحمر
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
//                   onPressed: uploadData,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor:
//                         Color.fromRGBO(255, 58, 58, 1), // اللون الأحمر
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
