// Custom Header for Guide Page
import 'package:flutter/material.dart';
import 'package:swine_care/colors/ArgieColors.dart';
import 'package:swine_care/global_widget/PrimaryHeader/CircularContainer.dart';
import 'package:swine_care/global_widget/PrimaryHeader/CurvedEdgeWidget.dart';

class GuidePageHeader extends StatelessWidget {
  final Widget child;

  const GuidePageHeader({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return CurvedEdgeWidget(
      child: Container(
        padding: const EdgeInsets.only(bottom: 20.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ArgieColors.primary,
              ArgieColors.third.withValues(alpha: 0.7),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            // Animated Circular Overlays
            Positioned(
              top: -120,
              right: -180,
              child: AnimatedContainer(
                duration: const Duration(seconds: 4),
                curve: Curves.easeInOut,
                transform: Matrix4.translationValues(0, 15, 0),
                child: CircularContainer(
                  width: 300,
                  height: 300,
                  radius: 150,
                  backgroundColor: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          ArgieColors.secondary.withValues(alpha: 0.4),
                          Colors.transparent,
                        ],
                        radius: 0.9,
                        center: Alignment.center,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -80,
              left: -120,
              child: CircularContainer(
                width: 250,
                height: 250,
                radius: 125,
                backgroundColor: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        ArgieColors.primary.withValues(alpha: 0.3),
                        Colors.transparent,
                      ],
                      radius: 0.8,
                      center: Alignment.center,
                    ),
                  ),
                ),
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}