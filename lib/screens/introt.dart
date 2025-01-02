import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xyz/screens/login.dart';

class Introt extends StatelessWidget {
  const Introt({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(253, 253, 253, 1),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          const SizedBox(
            height: 40,
          ),
          Image.asset(
            'assets/intro2.png',
          ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const Login()));
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: const Color.fromRGBO(253, 253, 253, 1),
              backgroundColor: const Color.fromRGBO(255, 58, 58, 1),
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              textStyle: const TextStyle(
                fontSize: 20,
                // fontWeight: FontWeight.bold,
              ),
            ),
            child: Text(
              '             لنبدأ            ',
              style: GoogleFonts.cairo(),
            ),
          )
        ]),
      ),
    );
  }
}
