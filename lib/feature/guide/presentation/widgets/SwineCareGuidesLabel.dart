import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swine_care/colors/ArgieColors.dart';

class SwineCareGuidesLabel extends StatelessWidget {
  const SwineCareGuidesLabel({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Text(
      "SwineCare Health & Farm Insights",
      style: GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: isDarkMode ? Colors.white : ArgieColors.primary,
        shadows: isDarkMode
            ? []
            : [
          Shadow(
            color: ArgieColors.shadow.withValues(alpha: 0.3),
            offset: const Offset(2, 2),
            blurRadius: 4,
          ),
        ],
      ),
    );
  }
}