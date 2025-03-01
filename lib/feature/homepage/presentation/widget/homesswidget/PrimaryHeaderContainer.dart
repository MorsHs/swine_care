import 'package:flutter/material.dart';
import 'package:swine_care/colors/ArgieColors.dart';
import 'package:swine_care/feature/homepage/presentation/widget/homesswidget/CircularContainer.dart';
import 'package:swine_care/feature/homepage/presentation/widget/homesswidget/CurvedEdgeWidget.dart';

class PrimaryHeaderContainer extends StatelessWidget {
  const PrimaryHeaderContainer({
    super.key, required this.child
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CurvedEdgeWidget(
      child: Container(
        color: ArgieColors.primary,
        padding: EdgeInsets.only(bottom: 0),
        child: Stack(
          children: [
            Positioned(
              top: -150,
              right: -250,
              child: CircularContainer(
                backgroundColor:
                ArgieColors.textthirdary.withValues(alpha: 0.1),
              ),
            ),
            Positioned(
              top: 100,
              right: -300,
              child: CircularContainer(
                backgroundColor:
                ArgieColors.textthirdary.withValues(alpha: 0.1),

              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}