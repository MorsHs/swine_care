import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckerButton extends StatelessWidget {
  const CheckerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: ElevatedButton(
        onPressed: () {
          // Add save functionality here
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 12,
          ),
        ),
        child: Text(
          "Answer this follow up questions.",
          style: GoogleFonts.concertOne(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
