import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.8,
      child: FilledButton(
        onPressed: () {
          context.go('/login');
        },
        child: const Text("Get Started"),
      ),
    );
  }
}
