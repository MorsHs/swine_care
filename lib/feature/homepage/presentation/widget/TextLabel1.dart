import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextLabel1 extends StatelessWidget {
  const TextLabel1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'Detect ASF in Your Pigs',
      style: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }
}