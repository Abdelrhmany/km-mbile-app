import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xyz/screens/compunanat/singleitem.dart';

// الكلاس المخصص
class MainCard extends StatelessWidget {
  List catlist = [];
  MainCard({super.key, required this.catlist});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            catlist.length,
            (index) {
              var item = catlist[index];
              var imageBase64 =
                  item['images'][0].split(',')[1]; // إزالة الـ prefix
              Uint8List imageBytes = base64Decode(imageBase64);

              return Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.shade200),
                  width: 223,
                  height: 244,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
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
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20), //

                            child: Image.memory(
                              imageBytes,
                              width: 223,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Text(
                          item['title'],
                          style: GoogleFonts.cairo(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
              );
            },
          ),
        ),
      ),
    );
  }
}
