import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DontHaveAnAccount extends StatelessWidget {
  const DontHaveAnAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.go('/signup');
      },
      child: const Text(
        "DON'T HAVE AN ACCOUNT? JOIN NOW",
        style: TextStyle(color: Colors.black54,
          fontWeight: FontWeight.w600,
          fontSize: 15,)
      ),
    );
  }
}
