import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swine_care/colors/ArgieColors.dart';
import 'package:swine_care/colors/ArgieSizes.dart';

class CheckerButton extends StatelessWidget {
  final GlobalKey symptomsSectionKey;

  const CheckerButton({
    super.key,
    required this.symptomsSectionKey,
  });

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions using MediaQuery
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Define responsive scaling factors
    final double scaleFactor = screenWidth / 375; // Base width (e.g., iPhone 14)
    final double fontSize = (14 * scaleFactor).clamp(12, 16); // Clamp between 12 and 16
    final double iconSize = (18 * scaleFactor).clamp(16, 20); // Clamp between 16 and 20
    final double smallIconSize = (16 * scaleFactor).clamp(14, 18); // For the arrow
    final double paddingHorizontal = (ArgieSizes.paddingDefault * scaleFactor).clamp(12, 20);
    final double paddingVertical = (ArgieSizes.spaceBtwItems * scaleFactor).clamp(8, 16);
    final double spacing = (12 * scaleFactor).clamp(8, 16); // Space between elements
    final double borderRadius = (16 * scaleFactor).clamp(12, 20);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius),
        splashColor: Colors.white.withValues(alpha: 0.3),
        highlightColor: Colors.white.withValues(alpha: 0.1),
        onTap: () {
          // Scroll to the symptoms section
          if (symptomsSectionKey.currentContext != null) {
            Scrollable.ensureVisible(
              symptomsSectionKey.currentContext!,
              alignment: 0.2,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          }
        },
        child: Container(
          // Use constraints to prevent the button from becoming too wide or too narrow
          constraints: BoxConstraints(
            minWidth: 200 * scaleFactor,
            maxWidth: screenWidth * 0.9,
          ),
          decoration: BoxDecoration(
            color: ArgieColors.primary,
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: [
              BoxShadow(
                color: ArgieColors.primary.withValues(alpha: 0.3),
                blurRadius: 8 * scaleFactor,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(
            horizontal: paddingHorizontal,
            vertical: paddingVertical,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min, // Fit content
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(8 * scaleFactor),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.25),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.medical_services_outlined,
                  color: Colors.white,
                  size: iconSize,
                ),
              ),
              SizedBox(width: spacing),
              Flexible(
                child: Text(
                  "Answer Symptoms Checklist",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: fontSize,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis, // Prevent text overflow
                  maxLines: 1,
                ),
              ),
              SizedBox(width: spacing),
              Container(
                padding: EdgeInsets.all(4 * scaleFactor),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(10 * scaleFactor),
                ),
                child: Icon(
                  Icons.arrow_downward_rounded,
                  color: Colors.white,
                  size: smallIconSize,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}