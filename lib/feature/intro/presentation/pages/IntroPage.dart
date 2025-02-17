import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_indicator/loading_indicator.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 3000), () {
      context.go('/loading-screen');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "Assets/Logo/swinecarelogo.png",
              fit: BoxFit.contain,
              height: 180,
              width: 180,
            ),
            const SizedBox(height: 90),
            const SizedBox(
              width: 30,
              height: 30,
              child: LoadingIndicator(
                indicatorType: Indicator.ballBeat,
                colors: [Colors.blueAccent],
                strokeWidth: 2,
                backgroundColor: Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
