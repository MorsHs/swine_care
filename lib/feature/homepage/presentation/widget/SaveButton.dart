import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swine_care/colors/ArgieColors.dart';
import 'package:swine_care/colors/ArgieSizes.dart';

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
    }
    return (true, 'Ready to Analyze!');
  }

  void _showValidationDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          'Validation Status',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 18,
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
        backgroundColor: Theme.of(context).cardTheme.color ?? ArgieColors.ligth,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Corrected: Added parentheses to call the method
            },
            child: Text(
              'Close',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).brightness == Brightness.dark
                    ? ArgieColors.textthird
                    : ArgieColors.primary,
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
    final Color backgroundColor = isComplete
        ? ArgieColors.primary // Use primary color (assumed green) since greenAccent isn't defined
        : Colors.orange; // Fallback to orange for warning
    final Color textColor = _getContrastingColor(backgroundColor);

    return Padding(
      padding: const EdgeInsets.all(ArgieSizes.paddingDefault),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (isComplete) {
                  context.push('/homepage/results', extra: {
                    'uploadedImages': widget.uploadedImages,
                    'webImages': widget.webImages,
                    'symptoms': widget.symptoms,
                  });
                } else {
                  _showValidationDialog(context, missingMessage);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor,
                foregroundColor: textColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: ArgieSizes.spaceBtwItems,
                ),
                elevation: isComplete ? 6 : 2,
                shadowColor: isComplete
                    ? ArgieColors.shadow.withValues(alpha: 0.5)
                    : ArgieColors.shadow.withValues(alpha: 0.3),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isComplete ? Icons.check_circle : Icons.warning_amber_rounded,
                    size: 20,
                    color: textColor,
                  ),
                  const SizedBox(width: ArgieSizes.spaceBtwWidgets),
                  Text(
                    isComplete ? 'Save & Analyze' : 'Complete Data First',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Color _getContrastingColor(Color backgroundColor) {
    final double luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? Colors.black : ArgieColors.textthird;
  }
}