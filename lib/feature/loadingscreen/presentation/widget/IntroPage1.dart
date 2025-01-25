import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome to SwineCare",
              style: GoogleFonts.modak(
                  fontSize: 28
              ),
            ),
            SizedBox(
              width: screenWidth * 0.8,
              height: screenHeight * 0.4,
              child: Lottie.asset("assets/Animations/AnimationPigDance.json"),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child:  Text("AI-powered assistant for swine health,"
                           " helping you make smart care decisions.",
                style: TextStyle(
                  height: 1.5,
                  fontSize: 16,
                  fontStyle: FontStyle.italic
                )
              ),
            ),
          ],
        )
      ),
    );
  }
}
