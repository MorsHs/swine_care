import 'package:flutter/material.dart';
import 'package:swine_care/colors/ArgieColors.dart';
import 'package:swine_care/global_widget/PrimaryHeader/CircularContainer.dart';
import 'package:swine_care/global_widget/PrimaryHeader/CurvedEdgeWidget.dart';

class PrimaryHeaderContainer extends StatelessWidget {
  const PrimaryHeaderContainer({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CurvedEdgeWidget(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [ArgieColors.primary, ArgieColors.third],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: EdgeInsets.only(bottom: 20.0),
        child: Stack(
          children: [
            // First circle (top-right)
            Positioned(
              top: -150,
              right: -200,
              child: CircularContainer(
                width: 350,
                height: 350,
                radius: 100, // Half of width/height for perfect circle
                backgroundColor: Colors.transparent, // Removed to rely on gradient
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [ArgieColors.secondary.withValues(alpha: 0.3), Colors.transparent],
                      radius: 0.8,
                      center: Alignment.center,
                    ),
                  ),
                ),
              ),
            ),
            // // Second circle (bottom-right)
            // Positioned(
            //   top: 50,
            //   right: -250,
            //   child: CircularContainer(
            //     width: 340,
            //     height: 340,
            //     radius: 50, // Half of width/height for perfect circle
            //     backgroundColor: Colors.transparent, // Removed to rely on gradient
            //     child: Container(
            //       decoration: BoxDecoration(
            //         shape: BoxShape.circle,
            //         gradient: RadialGradient(
            //           colors: [ArgieColors.secondary.withOpacity(0.3), Colors.transparent],
            //           radius: 0.8,
            //           center: Alignment.center,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            child,
          ],
        ),
      ),
    );
  }
}