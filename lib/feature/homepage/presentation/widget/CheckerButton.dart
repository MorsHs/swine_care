import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckerButton extends StatelessWidget {
  const CheckerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
        child: Text(
          "Answer this follow-up questions",
          style: GoogleFonts.saira(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}