import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SwineCareGuidesLabel2 extends StatelessWidget {
  const SwineCareGuidesLabel2({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Text(
      "Empower your farm with expert insights. Learn, apply, and safeguard your swine’s future today!",
      style: GoogleFonts.poppins(
        fontSize: 16,
        color: isDarkMode ? Colors.white70 : Colors.grey[700],
      ),
    );
  }
}