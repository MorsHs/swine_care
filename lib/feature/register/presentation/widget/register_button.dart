import 'package:flutter/material.dart';
import 'package:swine_care/colors/ArgieColors.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(top: 18),
      child: FractionallySizedBox(
        widthFactor: 0.8,
        child: FilledButton(
          onPressed: () {
            // Add registration logic here
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
          child: const Text("Sign up"),
        ),
      ),
    );
  }
}