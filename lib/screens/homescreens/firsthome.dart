import 'package:animated_hint_textfield/animated_hint_textfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xyz/allitemscard.dart';
import 'package:xyz/screens/compunanat/maincard.dart';
import 'package:xyz/sevices/catfilt.dart';

import '../../sevices/global_data.dart';
import '../compunanat/itemlistvew.dart';

class Firsthome extends StatefulWidget {
  const Firsthome({super.key});

  @override
  State<Firsthome> createState() => _FirsthomeState();
}

class _FirsthomeState extends State<Firsthome> {
  @override
  Widget build(BuildContext context) {
    List elect = [];
    List prp = [];
    List cars = [];
    List services = [];
    List furniture = [];
    List camping = [];
    List gifts = [];
    List contracting = [];
    List family = [];
    List animals = [];
    List clothes = [];

    filterAndStoreByCategory(
      category: 'Cars',
      inputList: globalData,
      outputList: cars,
    );
    filterAndStoreByCategory(
      category: 'Property',
      inputList: globalData,
      outputList: prp,
    );
    filterAndStoreByCategory(
      category: 'Services',
      inputList: globalData,
      outputList: services,
    );
    filterAndStoreByCategory(
      category: 'Furniture',
      inputList: globalData,
      outputList: furniture,
    );
    filterAndStoreByCategory(
      category: 'Camping',
      inputList: globalData,
      outputList: camping,
    );
    filterAndStoreByCategory(
      category: 'Gifts',
      inputList: globalData,
      outputList: gifts,
    );
    filterAndStoreByCategory(
      category: 'Contracting',
      inputList: globalData,
      outputList: contracting,
    );
    filterAndStoreByCategory(
      category: 'Family',
      inputList: globalData,
      outputList: family,
    );
    filterAndStoreByCategory(
      category: 'Animals',
      inputList: globalData,
      outputList: animals,
    );
    filterAndStoreByCategory(
      category: 'Electronics',
      inputList: globalData,
      outputList: elect,
    );
    filterAndStoreByCategory(
      category: 'clo',
      inputList: globalData,
      outputList: clothes,
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Stack with image and AnimatedTextField
            Stack(
              children: [
                Image.asset(
                  'assets/tophomescreen.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                Positioned(
                  top: 130, // تحديد موقع العنصر داخل الـ Stack
                  left: 0,
                  right: 0,
                  child: AnimatedTextField(
                    animationType: Animationtype
                        .typer, // استخدام Animationtype.typer للأنيميشن
                    hintTextStyle: TextStyle(
                      fontStyle: GoogleFonts.cairo().fontStyle,
                      color: Color.fromRGBO(135, 135, 135, 1),
                      overflow: TextOverflow.ellipsis,
                    ),
                    hintTexts: const ['ابحث', 'ابحث عما', 'ابحث عما تريد'],
                    decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.search, color: Colors.white),
                      filled: true,
                      fillColor: const Color.fromRGBO(253, 253, 253, 1),
                      border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.red, width: 2),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      contentPadding: const EdgeInsets.all(12),
                    ),
                  ),
                ),
                const SizedBox(height: 200), // مساحة للـ TextField
              ],
            ),

            // Horizontal Scrollable Images
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        'assets/homecar.png',
                        width: 320,
                        height: 111,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        'assets/hedphone.png',
                        width: 320,
                        height: 111,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Button and Title with Arabic Text
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => allitemscard()));
                  },
                  child: Text(
                    "كل الفئات",
                    style: GoogleFonts.cairo(
                      fontSize: 15,
                      color: const Color.fromRGBO(255, 58, 58, 1),
                    ),
                  ),
                ),
                Text(
                  'اكتشف الفئات',
                  style: GoogleFonts.cairo(
                    fontSize: 20,
                    color: const Color.fromRGBO(65, 65, 65, 1),
                  ),
                  textAlign: TextAlign.right,
                ),
                const SizedBox(width: 10),
              ],
            ),

            // Horizontal Scrollable Category Images
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => ProductListScreen(
                                  prp,
                                )));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          'assets/cta/akar.png',
                          height: 50,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => ProductListScreen(
                                  cars,
                                )));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          'assets/cta/carcat.png',
                          height: 50,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => ProductListScreen(
                                  furniture,
                                )));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          'assets/cta/asas.png',
                          height: 50,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ProductListScreen(clothes),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          'assets/cta/malabes.png',
                          height: 50,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Title for "شقق وغرف للايجار"
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "شقق وغرف للايجار",
                style: GoogleFonts.cairo(
                  fontSize: 20,
                  color: const Color.fromRGBO(65, 65, 65, 1),
                ),
                textAlign: TextAlign.right,
              ),
            ),
            MainCard(catlist: prp),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "سيارات    ",
                style: GoogleFonts.cairo(
                  fontSize: 20,
                  color: const Color.fromRGBO(65, 65, 65, 1),
                ),
                textAlign: TextAlign.right,
              ),
            ),
            MainCard(catlist: cars),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "الكترونيات",
                style: GoogleFonts.cairo(
                  fontSize: 20,
                  color: const Color.fromRGBO(65, 65, 65, 1),
                ),
                textAlign: TextAlign.right,
              ),
            ),
            MainCard(catlist: elect),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
