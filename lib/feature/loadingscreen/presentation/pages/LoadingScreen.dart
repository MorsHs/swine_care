import 'package:flutter/material.dart';
import 'package:swine_care/feature/loadingscreen/presentation/widget/GetStarted.dart';
import 'package:swine_care/feature/loadingscreen/presentation/widget/IntroPage1.dart';
import 'package:swine_care/feature/loadingscreen/presentation/widget/IntroPage2.dart';
import 'package:swine_care/feature/loadingscreen/presentation/widget/IntroPage3.dart';
import 'package:swine_care/feature/loadingscreen/presentation/widget/PageIndicator.dart';

class Loadingscreen extends StatefulWidget {
  const Loadingscreen({super.key});

  @override
  State<Loadingscreen> createState() => _LoadingscreenState();
}

PageController _controller = PageController();
bool onLastPage = false;

class _LoadingscreenState extends State<Loadingscreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            PageView(
              onPageChanged: (index) {
                setState(() {
                  onLastPage = (index == 2);
                });
              },
              controller: _controller,
              children: const [
                IntroPage1(),
                IntroPage2(),
                IntroPage3(),
              ],
            ),
            PageIndicator(
              controller: _controller,
            ),
            const Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Center(
                child: GetStarted(),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}