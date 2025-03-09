import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swine_care/colors/ArgieColors.dart';

class CheckerButton extends StatelessWidget {
  const CheckerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Answer Follow-Up Questions",
        style: GoogleFonts.poppins(
          color: Theme.of(context).brightness == Brightness.dark
              ? ArgieColors.textthird
              : Theme.of(context).colorScheme.primary,
          fontSize: 16,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}