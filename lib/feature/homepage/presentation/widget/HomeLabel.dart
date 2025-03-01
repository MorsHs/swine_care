import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeLabel extends StatelessWidget {
  const HomeLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Home",
      style: GoogleFonts.saira(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}