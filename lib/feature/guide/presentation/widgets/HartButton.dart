import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HeartButton extends StatelessWidget {
  const HeartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go('/');
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(8),
        child: const Icon(
          Icons.library_add_check,
          size: 18,
          color: Colors.blueAccent,
        ),
      ),
    );
  }
}
