import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
            vertical: 12),
      child: Text(title,
        style: GoogleFonts.concertOne(
          fontSize: 22,
          color: Colors.black,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}
