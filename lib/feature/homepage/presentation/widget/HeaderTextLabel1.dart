import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderTextLabel1 extends StatelessWidget {
  const HeaderTextLabel1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row(
              //   children: [
              //     Container(
              //       padding: const EdgeInsets.all(6),
              //       decoration: BoxDecoration(
              //         color: Colors.white.withValues(alpha: 0.2),
              //         borderRadius: BorderRadius.circular(20),
              //       ),
              //       child: Image.asset('assets/Logo/logoswinecare.png',
              //         fit: BoxFit.cover,
              //         height: 40,
              //         width: 150,
              //       ),
              //     ),
              //     // const SizedBox(width: 8),
              //     // Text(
              //     //   'SwineCare',
              //     //   style: GoogleFonts.poppins(
              //     //     fontSize: 14,
              //     //     fontWeight: FontWeight.w500,
              //     //     color: Colors.white.withValues(alpha: 0.9),
              //     //   ),
              //     // ),
              //   ],
              // ),
              const SizedBox(height: 6),
              Text(
                'Protect Your Pigs from ASF',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.2,
                  shadows: [
                    Shadow(
                      offset: const Offset(0, 1),
                      blurRadius: 3.0,
                      color: Colors.black.withValues(alpha: 0.3),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Removed the GestureDetector and AnimatedBuilder
        // Now using a static container with Iconsax.element_4 permanently
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ],
    );
  }
}