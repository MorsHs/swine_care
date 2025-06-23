import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swine_care/colors/ArgieColors.dart';

class HistoryEmptyState extends StatelessWidget {
  final bool isDarkMode;

  const HistoryEmptyState({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/sleepingpig.png',
            width: 200,
            height: 200,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 16),
          Text(
            'No Diagnosis History',
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: isDarkMode ? ArgieColors.textthird : ArgieColors.textBold,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(
              'Your past ASF assessments will appear here once you perform a diagnosis.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: isDarkMode ? ArgieColors.textthird.withValues(alpha: 0.7)  : ArgieColors.textSemiBlack,
              ),
            ),
          ),
        ],
      ),
    );
  }
}