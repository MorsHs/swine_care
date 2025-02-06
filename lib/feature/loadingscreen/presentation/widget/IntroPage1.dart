import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Welcome to",
              style: GoogleFonts.concertOne(fontSize: 30),
            ),
            Text(
              "SwineCare",
              style: GoogleFonts.concertOne(fontSize: 42),
            ),
            SizedBox(
              width: screenWidth * 0.8,
              height: screenHeight * 0.4,
              child: Lottie.asset("assets/Animations/AnimationPigDance.json"),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                "Your ultimate AI-powered assistant for swine health! "
                    "SwineCare helps you monitor, diagnose, and make smart decisions to ensure your pigs stay healthy and disease-free.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  height: 1.5,
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
