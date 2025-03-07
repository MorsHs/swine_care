import 'package:flutter/material.dart';
import 'package:swine_care/global_widget/PrimaryHeader/CurvedEdgeComponent.dart';

class CurvedEdgeWidget extends StatelessWidget {
  const CurvedEdgeWidget({
    super.key, this.child
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CurvedEdgeComponent(),
      child: child
    );
  }
}