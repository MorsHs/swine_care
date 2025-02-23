import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SwineCareGuidesLabel extends StatelessWidget {
  const SwineCareGuidesLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "SwineCare Health & Farm Insights",
      style: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
