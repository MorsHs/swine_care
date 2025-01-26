import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageIndicator extends StatelessWidget {
  final PageController controller;

  const PageIndicator({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20),
      alignment: const Alignment(0, 0.75),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SmoothPageIndicator for the page view
          SmoothPageIndicator(
            controller: controller,
            count: 3,
            effect: ExpandingDotsEffect(
              dotWidth: 10,
              dotHeight: 10,
              activeDotColor: Colors.deepPurpleAccent,
              dotColor: Colors.black54,
              spacing: 10,
              expansionFactor: 2,
            ),
          ),
        ],
      ),
    );
  }
}