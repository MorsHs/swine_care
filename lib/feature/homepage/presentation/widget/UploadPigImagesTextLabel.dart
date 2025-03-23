import 'package:flutter/material.dart';
import 'package:swine_care/colors/ArgieColors.dart';

class UploadPigImagesTextLabel extends StatelessWidget {
  const UploadPigImagesTextLabel({
    super.key,
    required this.isDarkMode,
  });

  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: ArgieColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.camera_alt,
            color: ArgieColors.primary,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          "Upload Pig Images",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.grey.shade800,
          ),
        ),
      ],
    );
  }
}
