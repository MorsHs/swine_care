import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckerButton extends StatelessWidget {
  const CheckerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          // Add your onPressed code here!
        },
        child: Text(
          "Answer Follow-Up Questions",
          style: GoogleFonts.poppins(
            color: Colors.green,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline, // Add underline for clickable appearance
          ),
        ),
      ),
    );
  }
}