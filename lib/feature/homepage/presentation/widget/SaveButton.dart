import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: ElevatedButton(
        onPressed: () {

        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 12,
          ),
        ),
        child: Text(
          "SAVE",
          style: GoogleFonts.concertOne(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
