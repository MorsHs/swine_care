import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swine_care/colors/ArgieColors.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return FractionallySizedBox(
      widthFactor: 0.8,
      child: FilledButton(
        onPressed: () {
          context.go('/homepage');
        },
        style: FilledButton.styleFrom(
          backgroundColor: ArgieColors.primary,
          foregroundColor: ArgieColors.textthird,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        child: const Text("Login"),
      ),
    );
  }
}