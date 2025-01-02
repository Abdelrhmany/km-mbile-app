import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:google_fonts/google_fonts.dart';
import 'singleitem.dart';

class ProductListScreen extends StatelessWidget {
  final List products;

  ProductListScreen(this.products);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('المنتجات', style: TextStyle(fontFamily: 'Cairo')),
      ),
      body: products.isEmpty
          ? Center(child: CircularProgressIndicator()) // إذا كانت القائمة فارغة
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                var item = products[index];

                // تحويل الصورة من base64 إلى Uint8List
                var imageBase64 =
                    item['images'][0].split(',')[1]; // إزالة الـ prefix
                Uint8List imageBytes = base64Decode(imageBase64);

                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: () {
                      // الانتقال إلى صفحة التفاصيل عند الضغط على الكارد
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailsScreen(
                            product: item,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.shade200,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.memory(
                                imageBytes,
                                width: double
                                    .infinity, // عرض الصورة بكامل عرض الكارد
                                height: 150, // يمكنك تعديل الارتفاع حسب احتياجك
                                fit: BoxFit
                                    .cover, // تأكد من أن الصورة تملأ الكارد بشكل مناسب
                              ),
                            ),
                            SizedBox(height: 8), // مسافة بين الصورة والعنوان
                            Text(
                              item['title'],
                              style: GoogleFonts.cairo(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4), // مسافة بين العنوان والوصف
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(item['description']),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Text('د.ك'),
                                    Text(
                                      '${item['price']}',
                                      style: TextStyle(
                                        color: Colors.green[700],
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Icon(Icons.location_on_outlined),
                                    const SizedBox(width: 25),
                                    Text('${item['location']}'),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
