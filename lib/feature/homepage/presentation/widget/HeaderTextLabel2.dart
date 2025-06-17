import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderTextLabel2 extends StatelessWidget {
  final GlobalKey? uploadSectionKey;

  const HeaderTextLabel2({
    super.key,
    this.uploadSectionKey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.poppins(
                  fontSize:  MediaQuery.of(context).size.width * 0.04,
                  color: Colors.white.withValues(alpha: 0.9),
                  height: 1.5,
                ),
                children: [
                  TextSpan(
                    text: 'Upload clear images ',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(
                    text: 'of your pigs for instant ASF detection and get expert recommendations.',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              if (uploadSectionKey?.currentContext != null) {
                Scrollable.ensureVisible(
                  uploadSectionKey!.currentContext!,
                  // alignment: 0.1,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              }
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_downward,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}