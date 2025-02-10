import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

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
              "How It Works",
              style: GoogleFonts.saira(
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: screenWidth * 0.8,
              height: screenHeight * 0.4,
              child: Lottie.asset("assets/Animations/AnimationHowItWorks.json"),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                "SwineCare utilizes AI and real-time data analysis to monitor your pigs' health. "
                    "It provides personalized insights, helping you detect early signs of disease, "
                    "optimize nutrition, and enhance farm management for maximum productivity.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 18,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
