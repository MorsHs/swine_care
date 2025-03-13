import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swine_care/colors/ArgieColors.dart';

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
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height * 0.04,
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: MediaQuery.of(context).size.width * 0.07,
          fontWeight: FontWeight.w500,
          color: color ?? (isDarkMode ? ArgieColors.textthird : ArgieColors.textBold),
          shadows: [
            Shadow(
              color: isDarkMode
                  ? ArgieColors.primary.withValues(alpha: 0.3)
                  : ArgieColors.primary.withValues(alpha: 0.2),
              offset: const Offset(1, 1),
              blurRadius: 3,
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
