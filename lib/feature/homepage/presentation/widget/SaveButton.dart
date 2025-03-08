import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swine_care/feature/homepage/presentation/pages/ResultsPage.dart';
import 'package:swine_care/colors/ArgieColors.dart';

class SaveButton extends StatefulWidget {
  final Map<String, File?> uploadedImages;
  final Map<String, Uint8List?> webImages;
  final Map<String, bool?> symptoms;

  const SaveButton({
    super.key,
    required this.uploadedImages,
    required this.webImages,
    required this.symptoms,
  });

  @override
  State<SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  (bool isComplete, String missingMessage) _checkDataCompleteness() {
    bool imagesComplete = kIsWeb
        ? widget.webImages.values.every((image) => image != null)
        : widget.uploadedImages.values.every((image) => image != null);
    bool symptomsComplete = widget.symptoms.values.every((symptom) => symptom != null);

    if (!imagesComplete && !symptomsComplete) {
      return (false, 'Missing images and symptoms');
    } else if (!imagesComplete) {
      return (false, 'Missing images for some pig parts');
    } else if (!symptomsComplete) {
      return (false, 'Symptoms checklist incomplete');
    } else {
      return (true, 'Ready to analyze!');
    }
  }

  void _showValidationDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Validation Status',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.bodyLarge!.color,
          ),
        ),
        content: Text(
          message,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Theme.of(context).textTheme.bodyMedium!.color,
          ),
        ),
        backgroundColor: Theme.of(context).cardTheme.color,
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: Text(
              'Close',
              style: GoogleFonts.poppins(
                color: Theme.of(context).brightness == Brightness.dark
                    ? ArgieColors.textthird // Use white in dark mode
                    : Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final (bool isComplete, String missingMessage) = _checkDataCompleteness();

    // Determine text/icon color based on background for better contrast
    final Color backgroundColor = isComplete
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).textTheme.bodyMedium!.color!;
    final Color textColor = _getContrastingColor(backgroundColor);

    return Center(
      child: ElevatedButton(
        onPressed: () {
          if (isComplete) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ResultsPage(
                  uploadedImages: widget.uploadedImages,
                  symptoms: widget.symptoms,
                ),
              ),
            );
          } else {
            _showValidationDialog(context, missingMessage);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isComplete ? Theme.of(context).colorScheme.primary : Theme.of(context).textTheme.bodyMedium!.color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          elevation: isComplete ? 8 : 2,
          shadowColor: isComplete
              ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.5)
              : Theme.of(context).textTheme.bodyMedium!.color!.withValues(alpha: 0.3),
          foregroundColor: textColor,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isComplete ? Icons.save : Icons.warning_amber_rounded,
              size: 20,
              color: textColor,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                isComplete ? "Save & Analyze" : missingMessage,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.fade,
                softWrap: false,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to determine a contrasting color for text/icon
  Color _getContrastingColor(Color backgroundColor) {
    final double luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? Colors.black : ArgieColors.textthird; // Use white for dark backgrounds
  }
}