import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Skip",
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(width: 4), // Adds spacing between text and icon
                    Icon(
                      Icons.arrow_forward, // Skip icon
                      color: Colors.black,
                      size: 15, // Adjust size as needed
                    ),
                  ],
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
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: const Text(
                  "Get Started",
                  style: TextStyle(
                      color: Colors.black
                  ),
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
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: const Row(
                  mainAxisSize: MainAxisSize.min, // Keep the row as compact as possible
                  children: [
                    Text(
                      "Next",
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                      size: 16, // Adjust icon size
                    ),
                  ],
                ),
              ),

            ),
          ],

        )
    );
  }
}
