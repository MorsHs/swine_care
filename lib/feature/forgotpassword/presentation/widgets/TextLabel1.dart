import 'package:flutter/material.dart';

class TextLabel1 extends StatelessWidget {
  const TextLabel1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Enter your email to reset your password',
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }
}