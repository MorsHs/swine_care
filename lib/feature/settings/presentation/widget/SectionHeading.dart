import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swine_care/colors/ArgieColors.dart';

class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    this.textColor,
    this.showActionButton = true,
    required this.tittle,
    this.buttnTille = 'View all',
    this.onPressed,
  });

  final Color? textColor;
  final bool showActionButton;
  final String tittle, buttnTille;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          tittle,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textColor ?? Theme.of(context).textTheme.bodyLarge?.color,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (showActionButton)
          TextButton(
            onPressed: onPressed,
            child: Text(
              buttnTille,
              style: GoogleFonts.poppins(
                color: ArgieColors.primary,
                fontSize: 14,
              ),
            ),
          ),
      ],
    );
  }
}