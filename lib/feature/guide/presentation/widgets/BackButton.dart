import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BackButtonToGuidePage extends StatelessWidget {
  const BackButtonToGuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return   GestureDetector(
      onTap: () {
        context.go('/guide');
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          color: Colors.black38,
        ),
        padding: const EdgeInsets.all(8),
        child: const Icon(
          Icons.arrow_back_ios,
          size: 18,
          color: Colors.black54,
        ),
      ),
    );
  }
}
