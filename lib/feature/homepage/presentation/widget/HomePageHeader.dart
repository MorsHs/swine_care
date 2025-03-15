import 'package:flutter/material.dart';
import 'package:swine_care/colors/ArgieColors.dart';
import 'package:swine_care/global_widget/PrimaryHeader/CircularContainer.dart';
import 'package:swine_care/global_widget/PrimaryHeader/CurvedEdgeWidget.dart';

class HomePageHeader extends StatelessWidget {
  final Widget child;

  const HomePageHeader({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return CurvedEdgeWidget(
      child: Container(
        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ArgieColors.primary.withValues(alpha: 0.9),
              ArgieColors.third.withValues(alpha: 0.6),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: (isDarkMode ? 0.2 : 0.1)),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [

            // Refined Circular Overlay 1 (Top Right)
            Positioned(
              top: -120, // Slightly smaller positioning
              right: -180,
              child: AnimatedContainer(
                duration: const Duration(seconds: 4),
                curve: Curves.easeInOutSine,
                transform: Matrix4.translationValues(0, 20, 0),
                child: CircularContainer(
                  width: 300, // Reduced size for cleaner look
                  height: 300,
                  radius: 150,
                  backgroundColor: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          ArgieColors.secondary.withValues(alpha: 0.2), // More transparent
                          Colors.transparent,
                        ],
                        radius: 0.9, // Wider spread for softness
                        center: Alignment.center,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Refined Circular Overlay 2 (Bottom Left)
            Positioned(
              bottom: -80, // Adjusted for balance
              left: -120,
              child: CircularContainer(
                width: 250, // Smaller and cleaner
                height: 250,
                radius: 125,
                backgroundColor: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        ArgieColors.primary.withValues(alpha: 0.15),
                        Colors.transparent,
                      ],
                      radius: 0.8,
                      center: Alignment.center,
                    ),
                  ),
                ),
              ),
            ),

            // Child content with improved alignment
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  child, // Existing child (TextLabel1, TextLabel2, etc.)
                  const SizedBox(height: 10.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}