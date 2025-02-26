import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
//SDADAS
    return
        Container(
          padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.4,
                  child: Lottie.asset("assets/Animations/AnimationHowItWorks.json",
                      frameRate: FrameRate.max),
                ),
                Text(
                  "Understanding SwineCare",
                  style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(height: 4),
                 Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    "AI-driven insights to detect diseases early, optimize nutrition, and boost productivity.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                 ),
              ],
            ),
          ),
        );

  }
}
