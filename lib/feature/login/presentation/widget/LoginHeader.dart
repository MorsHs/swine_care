import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swine_care/colors/ArgieColors.dart';
import 'package:swine_care/global_widget/LogoImage.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
    required this.isDarkMode,
  });

  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05,
        vertical: MediaQuery.of(context).size.height * 0.02,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
          const Logoimage(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          Text(
            "Welcome to SwineCare!",
            style: GoogleFonts.poppins(
              fontSize: MediaQuery.of(context).size.width * 0.07,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? ArgieColors.textthird : ArgieColors.textBold,
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
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Text(
            "Protect your pigs with expert care and insights.",
            style: GoogleFonts.poppins(
              fontSize: MediaQuery.of(context).size.width * 0.04,
              color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
        ],
      ),
    );
  }
}