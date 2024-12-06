import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:swine_care/colors/colors.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Assurance and Support",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.normal,
                color: appBlack
              ),
            ),
            SizedBox(
              width: screenWidth * 0.8,
              height: screenHeight * 0.4,
              child: Lottie.asset("assets/Animations/AnimationSupport1.json"),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text("Rest easy knowing your pigs are in safe hands."
                  " Our goal is to empower farmers with actionable"
                  " insights for managing ASF effectively. "
                  "Start now to protect your pigs and your livelihood!",
              style: TextStyle(
                height: 1.5,
                fontStyle: FontStyle.italic,
                fontSize: 16
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}
