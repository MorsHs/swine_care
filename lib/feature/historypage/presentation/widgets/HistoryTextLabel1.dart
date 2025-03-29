import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swine_care/colors/ArgieColors.dart';
import 'package:swine_care/colors/ArgieSizes.dart';

class HistoryTextLabel1 extends StatelessWidget {
  const HistoryTextLabel1({
    super.key,
    required this.isDarkMode,
  });

  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(ArgieSizes.paddingDefault),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "History",
              style: GoogleFonts.poppins(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? ArgieColors.textthird : ArgieColors.textBold,
              ),
            ),
            const SizedBox(height: ArgieSizes.spaceBtwItems),
          ],
        ),
      ),
    );
  }
}