import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:swine_care/colors/colors.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Assurance and",
                style: GoogleFonts.saira(
                    fontSize: 40,
                    color: appBlack,
                    fontWeight: FontWeight.bold
                ),
              ),
              Text(
                "Support",
                style: GoogleFonts.saira(
                    fontSize: 40,
                    color: appBlack,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(
                width: screenWidth * 0.8,
                height: screenHeight * 0.4,
                child: Lottie.asset("assets/Animations/AnimationAnalysis.json"),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "With SwineCare, you get real-time health insights and early alerts for ASF and other diseases. "
                      "Our AI-driven support ensures your pigs receive the best care, preventing outbreaks and reducing risks for your farm.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height: 1.5,
                    fontStyle: FontStyle.italic,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
