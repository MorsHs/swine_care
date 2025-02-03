import 'package:flutter/material.dart';

class SwineCareGuidesLabel extends StatelessWidget {
  const SwineCareGuidesLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Text(
      "SwineCare Guides",
      style: TextStyle(
          color: Color(0xFFF35E7A),
          fontSize: 24,
          fontWeight: FontWeight.bold),
    );
  }
}
