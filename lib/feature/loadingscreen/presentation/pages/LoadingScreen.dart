import 'package:flutter/material.dart';
import 'package:swine_care/feature/loadingscreen/presentation/widget/DontHaveAnAccount.dart';
import 'package:swine_care/feature/loadingscreen/presentation/widget/GetStarted.dart';
import 'package:swine_care/feature/loadingscreen/presentation/widget/IntroPage1.dart';
import 'package:swine_care/feature/loadingscreen/presentation/widget/IntroPage2.dart';
import 'package:swine_care/feature/loadingscreen/presentation/widget/IntroPage3.dart';
import 'package:swine_care/feature/loadingscreen/presentation/widget/PageIndicator.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

PageController _controller = PageController();
bool onLastPage = false;

class _LoadingScreenState extends State<LoadingScreen> {
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
            const SizedBox(height: 10),
            const Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Column(
                children: [
                    GetStarted(),
                  SizedBox(height: 5),
                  DontHaveAnAccount(),
                ],
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}