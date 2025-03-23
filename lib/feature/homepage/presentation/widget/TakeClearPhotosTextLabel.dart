import 'package:flutter/material.dart';

class TakeClearPhotosTextLabel extends StatelessWidget {
  const TakeClearPhotosTextLabel({
    super.key,
    required this.isDarkMode,
  });

  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Text(
      "Take clear photos of all required parts for accurate detection:",
      style: TextStyle(
        fontSize: 14,
        color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade700,
      ),
    );
  }
}
