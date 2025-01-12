import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';

class ProductDetailsScreen extends StatelessWidget {
  final Map product;

  ProductDetailsScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    List<String> imageBase64List = product['images']
        .map<String>((image) => image.split(',')[1])
        .toList(); // إزالة الـ prefix لكل الصور

    List<Uint8List> imageBytesList =
        imageBase64List.map((image) => base64Decode(image)).toList();

    String condition = product['category'];
    bool showExtraFields = condition == 'Cars'; // تحقق إذا كانت الحالة جديدة

    return Scaffold(
      appBar: AppBar(
        title: Text('تفاصيل المنتج', style: TextStyle(fontFamily: 'Cairo')),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // عرض الصور المتعددة باستخدام PageView
              Container(
                height: 250,
                child: PageView.builder(
                  itemCount: imageBytesList.length,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.memory(
                        imageBytesList[index],
                        width: double.infinity,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 16),
              Text(
                product['title'],
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                ),
              ),
              SizedBox(height: 8),
              Text(
                'الوصف:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                ),
              ),
              SizedBox(height: 8),
              Text(
                product['description'],
                style: TextStyle(fontSize: 16, fontFamily: 'Cairo'),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'السعر: ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                    ),
                  ),
                  Text(
                    '${product['price']} د.ك',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.green[700],
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.location_on_outlined),
                  SizedBox(width: 8),
                  Text(
                    product['location'],
                    style: TextStyle(fontSize: 16, fontFamily: 'Cairo'),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'حالة المنتج: ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                    ),
                  ),
                  Text(
                    product['condition'],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              // إظهار الحقول الإضافية بناءً على الشرط
              if (showExtraFields) ...[
                _buildField(Icons.branding_watermark, "العلامة التجارية",
                    product['brand'], ''),
                _buildField(
                    Icons.date_range, "سنة الموديل", product['modelYear'], ''),
                _buildField(Icons.speed, "السرعة", product['km'], 'km/h'),
                _buildField(Icons.engineering, "السعة اللترية للمحرك",
                    product['engineCC'], 'cc'),
                _buildField(Icons.local_gas_station, "نوع الوقود",
                    product['fuelType'], ''),
                _buildField(Icons.access_time, "التسارع (من 0 لـ 100)",
                    product['transmission'], 'sec'),
                _buildField(
                    Icons.drive_eta, "نظام الدفع", product['drivetrain'], ''),
                _buildField(Icons.sensor_door_sharp, "عدد الأبواب",
                    product['doors'], ''),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // دالة مساعدة لعرض الحقول بشكل موحد
  Widget _buildField(IconData icon, String label, String value, String unit) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blue),
          SizedBox(width: 8),
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'Cairo',
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Cairo',
            ),
          ),
          Text(
            unit,
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Cairo',
            ),
          ),
        ],
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'dart:typed_data';

// class ProductDetailsScreen extends StatelessWidget {
//   final Map product;

//   ProductDetailsScreen({required this.product});

//   @override
//   Widget build(BuildContext context) {
//     var imageBase64 = product['images'][0].split(',')[1]; // إزالة الـ prefix
//     Uint8List imageBytes = base64Decode(imageBase64);

//     // التحقق من حالة المنتج
//     String condition = product['category'];
//     bool showExtraFields = condition ==
//         'Cars'; // تحقق إذا كانت الحالة جديدة لإظهار الحقول الإضافية

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('تفاصيل المنتج', style: TextStyle(fontFamily: 'Cairo')),
//       ),
//       body: SingleChildScrollView(
//         // استخدام SingleChildScrollView للسماح بالتمرير
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(20),
//                 child: Image.memory(
//                   imageBytes,
//                   width: double.infinity,
//                   height: 250,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               SizedBox(height: 16),
//               Text(
//                 product['title'],
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: 'Cairo',
//                 ),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 'الوصف:',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: 'Cairo',
//                 ),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 product['description'],
//                 style: TextStyle(fontSize: 16, fontFamily: 'Cairo'),
//               ),
//               SizedBox(height: 16),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Text(
//                     'السعر: ',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       fontFamily: 'Cairo',
//                     ),
//                   ),
//                   Text(
//                     '${product['price']} د.ك',
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.green[700],
//                       fontWeight: FontWeight.bold,
//                       fontFamily: 'Cairo',
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 16),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Icon(Icons.location_on_outlined),
//                   SizedBox(width: 8),
//                   Text(
//                     product['location'],
//                     style: TextStyle(fontSize: 16, fontFamily: 'Cairo'),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 16),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Text(
//                     'حالة المنتج: ',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       fontFamily: 'Cairo',
//                     ),
//                   ),
//                   Text(
//                     product['condition'],
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.blue,
//                       fontFamily: 'Cairo',
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 16),
//               // إظهار الحقول الإضافية بناءً على الشرط
//               if (showExtraFields) ...[
//                 _buildField(Icons.branding_watermark, "العلامة التجارية",
//                     product['brand'], ''),
//                 _buildField(
//                     Icons.date_range, "سنة الموديل", product['modelYear'], ''),
//                 _buildField(Icons.speed, "السرعة", product['km'], 'km/h'),
//                 _buildField(Icons.engineering, "السعة اللترية للمحرك",
//                     product['engineCC'], 'cc'),
//                 _buildField(Icons.local_gas_station, "نوع الوقود",
//                     product['fuelType'], ''),
//                 _buildField(Icons.access_time, "التسارع (من 0 لـ 100)",
//                     product['transmission'], 'sec'),
//                 _buildField(
//                     Icons.drive_eta, "نظام الدفع", product['drivetrain'], ''),
//                 _buildField(Icons.sensor_door_sharp, "عدد الأبواب",
//                     product['doors'], ''),
//               ],
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // دالة مساعدة لعرض الحقول بشكل موحد
//   Widget _buildField(IconData icon, String label, String value, String x) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Icon(icon, color: Colors.blue), // إضافة الأيقونة
//           SizedBox(width: 8),
//           Text(
//             '$label: ',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: const Color.fromARGB(255, 0, 0, 0),
//               fontFamily: 'Cairo',
//             ),
//           ),
//           Text(
//             value,
//             style: TextStyle(
//               fontSize: 18,
//               fontFamily: 'Cairo',
//             ),
//           ),
//           Text(
//             x,
//             style: TextStyle(
//               fontSize: 18,
//               fontFamily: 'Cairo',
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
