import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swine_care/feature/homepage/presentation/pages/ResultsPage.dart';

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
    )..repeat(reverse: true
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Check data completeness and missing requirements
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

  // Show validation dialog
  void _showValidationDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Validation Status'),
        content: Text(
          message,
          style: GoogleFonts.poppins(fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final (bool isComplete, String missingMessage) = _checkDataCompleteness();

    return Center(
      child: Wrap(
        spacing: 8,
        alignment: WrapAlignment.center,
        children: [
          // Animated Save & Analyze Button
          ElevatedButton(
            onPressed: isComplete
                ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultsPage(
                    uploadedImages: widget.uploadedImages,
                    symptoms: widget.symptoms,
                  ),
                ),
              );
            }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: isComplete ? Colors.blueAccent : Colors.grey.shade400,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              elevation: isComplete ? 8 : 2,
              shadowColor: isComplete
                  ? Colors.blueAccent.withValues(alpha: 0.5)
                  : Colors.grey.withValues(alpha: 0.3),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isComplete ? Icons.save : Icons.warning_amber_rounded,
                  size: 20,
                  color: Colors.white,
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    isComplete ? "Save & Analyze" : missingMessage,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                  ),
                ),
              ],
            ),
          ),

          // Info Icon Button (Overlay on Save Button)
          if (!isComplete)
            Positioned(
              right: 0,
              top: 0,
              child: IconButton(
                onPressed: () => _showValidationDialog(context, missingMessage),
                icon: Icon(
                  Icons.info_outline_rounded,
                  color: Colors.grey.shade600,
                  size: 24,
                ),
              ),
            ),
        ],
      ),
    );
  }
}