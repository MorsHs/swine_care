import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Positioned.fill(
            child: Image.asset(
                'assets/images/loadingscreenbackground/background6.jpg',
            fit: BoxFit.cover,
            ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.4,
                  child:
                      Lottie.asset("assets/Animations/AnimationPigDance.json"),
                ),
                Text(
                  "Welcome to SwineCare",
                  style: GoogleFonts.saira(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  ),
                ),
                SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    "Your ultimate AI-powered assistant for swine health! "
                    "SwineCare helps you monitor, diagnose, and make smart decisions to ensure your pigs stay healthy and disease-free.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      height: 1.5,
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                        color: Colors.black
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
