import 'package:flutter/material.dart';
import 'package:swine_care/colors/ArgieColors.dart';
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

class _LoadingScreenState extends State<LoadingScreen> {
  final PageController _controller = PageController();
  bool onLastPage = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!mounted) return const SizedBox.shrink();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            // Decorative background elements
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    ArgieColors.primary.withValues(alpha: 0.1),
                    ArgieColors.secondary.withValues(alpha: 0.1),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: -50,
                    top: -20,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ArgieColors.primary.withValues(alpha: 0.1),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 40,
                    top: -60,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ArgieColors.primary.withValues(alpha: 0.1),
                      ),
                    ),
                  ),
                  Positioned(
                    left: -30,
                    bottom: -40,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ArgieColors.secondary.withValues(alpha: 0.1),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 40,
                    top: 20,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ArgieColors.primary.withValues(alpha: 0.3),
                      ),
                    ),
                  ),
                  Positioned(
                    left: -15,
                    top: 220,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ArgieColors.primary.withValues(alpha: 0.2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // PageView
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
            // Page Indicator
            PageIndicator(
              controller: _controller,
            ),
            // Get Started Button
            const Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Center(
                child: GetStarted(),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}