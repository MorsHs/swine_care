import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swine_care/colors/ArgieColors.dart';
import 'package:swine_care/global_widget/LogoImage.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({
    super.key,
    required this.isDarkMode,
  });

  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        MediaQuery.of(context).size.width * 0.05,
      ),
      // decoration: BoxDecoration(
      //   gradient: LinearGradient(
      //     colors: [
      //       ArgieColors.primary.withValues(alpha: (isDarkMode ? 0.2 : 0.4)),
      //       isDarkMode ? ArgieColors.dark : Colors.grey.shade100,
      //     ],
      //     begin: Alignment.topCenter,
      //     end: Alignment.bottomCenter,
      //   ),
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
          const Logoimage(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          Text(
            "Join SwineCare Today!",
            style: GoogleFonts.poppins(
              fontSize: MediaQuery.of(context).size.width * 0.07,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? ArgieColors.textthird : ArgieColors.textBold,
              shadows: [
                Shadow(
                  color: isDarkMode
                      ? ArgieColors.primary.withValues(alpha: 0.3)
                      : ArgieColors.primary.withValues(alpha: 0.3),
                  offset: const Offset(1, 1),
                  blurRadius: 3,
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Text(
            "Sign up to start protecting your pigs with ease.",
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