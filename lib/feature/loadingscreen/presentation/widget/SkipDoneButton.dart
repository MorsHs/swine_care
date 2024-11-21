import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:swine_care/Route/routes.dart';
import 'package:swine_care/feature/login/presentation/pages/Login.dart';

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
                onTap: (){
                  controller.jumpToPage(2);
                },
                child: const Text("skip")
            ),

            SmoothPageIndicator(
                controller: controller, count: 3
            ),

            onLastPage ?
            GestureDetector(
                onTap: (){
                 context.go('/login');
                },
                child: const Text("done")
            )

            // NEXT BUTTON
                : GestureDetector(
                onTap: (){
                  controller.nextPage(
                      duration: const Duration(
                          milliseconds: 300), curve: Curves.easeIn);
                },
                child: const Text("next")
            )

          ],
        )
    );
  }
}
