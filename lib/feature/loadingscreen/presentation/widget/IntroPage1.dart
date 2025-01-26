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
        body: Container(
          padding: EdgeInsets.only(top: 50,left: 20,right: 20),
          child: Center(
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Welcome to SwineCare",
                  style: GoogleFonts.modak(
                      fontSize: 40,
                    color: Color(0xFFF35E7A),
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.4,
                  child: Lottie.asset("assets/Animations/AnimationPigDance.json"),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child:  Text("AI-powered assistant \nfor swine health helping \nyou make smart care decisions.",
                    style: TextStyle(
                      height: 1.5,
                      fontSize: 24,
                      fontStyle: FontStyle.italic
                    )
                  ),
                ),
              ],
            )
          ),
        ),
      );

  }
}
