import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swine_care/colors/ArgieColors.dart';

class TextLabel2 extends StatelessWidget {
  const TextLabel2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color baseTextColor = isDarkMode ? ArgieColors.textthird : ArgieColors.textBold;
    final Color highlightTextColor = isDarkMode ? ArgieColors.textthird : ArgieColors.primary;
    final Color secondaryTextColor = isDarkMode ? ArgieColors.textthird : ArgieColors.textSemiBlack;

    print('TextLabel2 - Dark Mode: $isDarkMode, Base Color: $baseTextColor, Highlight Color: $highlightTextColor, Secondary Color: $secondaryTextColor');

    return RichText(
      text: TextSpan(
        style: GoogleFonts.poppins(
          fontSize: 16,
          color: baseTextColor,
          letterSpacing: 0.3,
          shadows: isDarkMode
              ? []
              : [
          ],
        ),
        children: [
          TextSpan(
            text: 'African Swine Fever (ASF) is a serious disease that affects pigs. ',
            style: GoogleFonts.poppins(fontWeight: FontWeight.normal),
          ),
          TextSpan(
            text: 'Early detection can save your pigs. ',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              color: highlightTextColor,
              shadows: isDarkMode
                  ? []
                  : [
              ],
            ),
          ),
          TextSpan(
            text: 'Upload clear images of the following parts of the pig for analysis:',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              color: secondaryTextColor,
            ),
          ),
        ],
      ),
    );
  }
}