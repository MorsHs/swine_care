import 'package:flutter/material.dart';
import 'package:swine_care/colors/ArgieColors.dart';

class ProgressIndicatorCard extends StatelessWidget {
  final int imagesUploaded;
  final int totalImages;
  final int questionsAnswered;
  final int totalQuestions;

  const ProgressIndicatorCard({
    Key? key,
    required this.imagesUploaded,
    required this.totalImages,
    required this.questionsAnswered,
    required this.totalQuestions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final double progress = (imagesUploaded + questionsAnswered) / (totalImages + totalQuestions);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? ArgieColors.darkAccent : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDarkMode
                ? Colors.black.withValues(alpha: 0.3)
                : Colors.grey.shade200,
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Detection Progress',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.grey.shade800,
                ),
              ),
              Text(
                '${(progress * 100).round()}%',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ArgieColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: isDarkMode
                  ? Colors.grey.shade800
                  : Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(ArgieColors.primary),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildProgressItem(
                context: context,
                icon: Icons.image,
                title: 'Images',
                current: imagesUploaded,
                total: totalImages,
                color: Colors.blue,
              ),
              _buildProgressItem(
                context: context,
                icon: Icons.check_circle_outline,
                title: 'Symptoms',
                current: questionsAnswered,
                total: totalQuestions,
                color: ArgieColors.orangeAccent,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required int current,
    required int total,
    required Color color,
  }) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: isDarkMode ? 0.2 : 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: color,
            size: 18,
          ),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isDarkMode ? Colors.white : Colors.grey.shade700,
              ),
            ),
            Text(
              '$current/$total',
              style: TextStyle(
                fontSize: 12,
                color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}