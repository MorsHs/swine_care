import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:swine_care/colors/colors.dart';

class SkipDoneButton extends StatelessWidget {
  SkipDoneButton({super.key, required this.controller, required this.onLastPage});

PageController controller = PageController();
  bool onLastPage = false;


  @override
  Widget build(BuildContext context) {
    return   Container(
        alignment: const Alignment(0, 0.75),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // SKIP BUTTON
            GestureDetector(
              onTap: () {
                controller.jumpToPage(2);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey), // Adjust color as needed
                  borderRadius: BorderRadius.circular(10), // Optional: rounded corners
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), // Add padding inside the border
                child: const Text(
                  "Skip",
                  style: TextStyle(color: Colors.black), // Adjust text style as needed
                ),
              ),
            ),

            SmoothPageIndicator(
              controller: controller,
              count: 3,
            ),

            onLastPage
                ? GestureDetector(
              onTap: () {
                context.go('/login');
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueAccent.shade100,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: const Text(
                  "Get Started",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            )
            // NEXT BUTTON
                : GestureDetector(
              onTap: () {
                controller.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: const Text(
                  "Next",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],

        )
    );
  }
}
