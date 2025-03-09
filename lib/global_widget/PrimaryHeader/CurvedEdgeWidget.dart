import 'package:flutter/cupertino.dart';

class CurvedEdgeWidget extends StatelessWidget {
  final Widget child;

  const CurvedEdgeWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _CurvedEdgeClipper(),
      child: child,
    );
  }
}

class _CurvedEdgeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 40); // Start curve higher for a smoother arc

    final firstControl = Offset(0, size.height - 20);
    final firstEnd = Offset(40, size.height - 20);
    path.quadraticBezierTo(firstControl.dx, firstControl.dy, firstEnd.dx, firstEnd.dy);

    final secondControl = Offset(size.width / 2, size.height);
    final secondEnd = Offset(size.width - 40, size.height - 20);
    path.quadraticBezierTo(secondControl.dx, secondControl.dy, secondEnd.dx, secondEnd.dy);

    final thirdControl = Offset(size.width, size.height - 20);
    final thirdEnd = Offset(size.width, size.height);
    path.quadraticBezierTo(thirdControl.dx, thirdControl.dy, thirdEnd.dx, thirdEnd.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}