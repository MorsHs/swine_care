import 'package:flutter/material.dart';

class SymptomsChecklistLabelText extends StatelessWidget {
  const SymptomsChecklistLabelText({
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
            color: Colors.amber.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.medical_services_outlined,
            color: Colors.amber.shade700,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          "Symptoms Checklist",
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