import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginOrCreateLabel extends StatelessWidget {
  final String label;
  final Color? color;

  const LoginOrCreateLabel({
    super.key,
    required this.label,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: color ??
              (isDarkMode ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}