import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SwineCareGuidesLabel extends StatelessWidget {
  const SwineCareGuidesLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return  Text(
      "SwineCare Guides",
      style: GoogleFonts.concertOne(
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
    );
  }
}
