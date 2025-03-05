import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextLabel2 extends StatelessWidget {
  const TextLabel2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: GoogleFonts.poppins(
          fontSize: 16,
          color: Colors.black87,
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
              color: Colors.green,
            ),
          ),
          TextSpan(
            text: 'Upload clear images of the following parts of the pig for analysis:',
            style: GoogleFonts.poppins(fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }
}