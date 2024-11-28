import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:swine_care/colors/colors.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(" How It Works",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: appBlack
              ),
            ),
             SizedBox(
               width: screenWidth * 0.8,
               height: screenHeight * 0.4,
               child:  Lottie.asset("assets/Animations/AnimationCamera1.json"),
             ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text("Simply upload a photo or provide details about your pig's symptoms."
                  " Our AI-powered system analyzes the information and offers "
                  "tailored suggestions to identify potential "
                  "ASF risks and ensure prompt care.",
              style: TextStyle(
                fontStyle: FontStyle.italic,
                    fontSize: 16
               ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
