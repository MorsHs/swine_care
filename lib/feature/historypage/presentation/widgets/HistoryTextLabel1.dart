import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swine_care/colors/ArgieColors.dart';
import 'package:swine_care/colors/ArgieSizes.dart';

class HistoryTextLabel1 extends StatelessWidget {
  final bool isDarkMode;

  const HistoryTextLabel1({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(
          horizontal: ArgieSizes.paddingDefault,
          vertical: ArgieSizes.paddingDefault * 1.5,
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Diagnosis History",
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: isDarkMode ? ArgieColors.textthird : ArgieColors.textBold,
                  letterSpacing: 0.2,
                  shadows: [
                    Shadow(
                      color: isDarkMode ? Colors.black26 : ArgieColors.textBold.withValues(alpha: 0.15) ,
                      blurRadius: 4,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: ArgieSizes.spaceBtwItems * 0.5),
              Text(
                "Track and review your past ASF assessments",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: isDarkMode ? ArgieColors.textthird.withValues(alpha: 0.8)  : ArgieColors.textSemiBlack.withValues(alpha: 0.9) ,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}