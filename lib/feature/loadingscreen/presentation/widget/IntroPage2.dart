import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:swine_care/colors/colors.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Keep your pigs safe",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: appBlack
              ),),
             SizedBox(
               width: screenWidth * 0.8,
               height: screenHight * 0.4,
               child:  Lottie.asset("assets/Animations/AnimationPigButterfly.json"),
             ),

          ],
        ),

      ),
    );
  }
}
