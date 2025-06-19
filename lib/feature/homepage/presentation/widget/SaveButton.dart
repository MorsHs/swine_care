import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swine_care/colors/ArgieColors.dart';
import 'package:swine_care/colors/ArgieSizes.dart';
import 'package:swine_care/data/model/Prediction.dart';

class SaveButton extends StatefulWidget {
  final Map<String, File?> uploadedImages;
  final Map<String, Uint8List?> webImages;
  final Map<String, bool?> symptoms;
  final List<Prediction>? earsPredictions;
  final List<Prediction>? skinPredictions;

  const SaveButton({
    super.key,
    required this.uploadedImages,
    required this.webImages,
    required this.symptoms,
    this.earsPredictions,
    this.skinPredictions,
  });

  @override
  State<SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _glowAnimation = Tween<double>(begin: 0.0, end: 0.5).animate(
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
          borderRadius: BorderRadius.circular(20),
        ),
        title: Row(
          children: [
            Icon(
              message.contains('Ready') ? Icons.check_circle : Icons.warning_amber_rounded,
              color: message.contains('Ready') ? Colors.green : Colors.orange,
              size: 24,
            ),
            const SizedBox(width: 8),
            Text(
              'Validation Status',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Theme.of(context).textTheme.bodyMedium!.color,
              ),
            ),
            if (!message.contains('Ready')) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
                ),
                child: Column(
                  children: [
                    Text(
                      'Missing Items:',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.orange.shade800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (message.contains('images'))
                      _buildMissingItemRow(
                        icon: Icons.image,
                        text: 'Upload images for ears and skin',
                      ),
                    if (message.contains('symptoms'))
                      _buildMissingItemRow(
                        icon: Icons.medical_services,
                        text: 'Complete all symptom questions',
                      ),
                  ],
                ),
              ),
            ],
          ],
        ),
        backgroundColor: Theme.of(context).cardTheme.color ?? ArgieColors.ligth,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
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
          if (message.contains('Ready'))
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.push('/results', extra: {
                  'uploadedImages': widget.uploadedImages,
                  'webImages': widget.webImages,
                  'symptoms': widget.symptoms,
                  'earsPredictions': widget.earsPredictions,
                  'skinPredictions': widget.skinPredictions,
                });
              },
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              child: Text(
                'Proceed',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: ArgieColors.primary,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMissingItemRow({required IconData icon, required String text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.orange.shade800, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.orange.shade800,
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
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Calculate upload progress
    int uploadedCount = 0;
    if (kIsWeb) {
      for (var webImage in widget.webImages.values) {
        if (webImage != null) uploadedCount++;
      }
    } else {
      for (var image in widget.uploadedImages.values) {
        if (image != null) uploadedCount++;
      }
    }

    // Calculate symptoms progress
    int answeredSymptoms = 0;
    for (var symptom in widget.symptoms.values) {
      if (symptom != null) answeredSymptoms++;
    }

    final double uploadProgress = uploadedCount / widget.uploadedImages.length;
    final double symptomsProgress = answeredSymptoms / widget.symptoms.length;
    final double totalProgress = (uploadProgress + symptomsProgress) / 2;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: ArgieSizes.paddingDefault,
        vertical: ArgieSizes.spaceBtwWidgets,
      ),
      child: Column(
        children: [
          // Progress indicators
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                Expanded(
                  child: _buildProgressIndicator(
                    label: 'Images',
                    progress: uploadProgress,
                    icon: Icons.photo_library,
                    color: ArgieColors.primary,
                    isDarkMode: isDarkMode,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildProgressIndicator(
                    label: 'Symptoms',
                    progress: symptomsProgress,
                    icon: Icons.medical_services,
                    color: Colors.orange,
                    isDarkMode: isDarkMode,
                  ),
                ),
              ],
            ),
          ),

          // Save button
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final Color backgroundColor = isComplete
                  ? ArgieColors.primary
                  : isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200;

              final Color textColor = isComplete
                  ? Colors.white
                  : isDarkMode ? Colors.white : Colors.black87;

              final double shadowStrength = isComplete ? _glowAnimation.value : 0.0;

              return DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: isComplete
                      ? [
                    BoxShadow(
                      color: ArgieColors.primary.withValues(alpha: shadowStrength),
                      blurRadius: 12,
                      spreadRadius: 2,
                    ),
                  ]
                      : [],
                ),
                child: Transform.scale(
                  scale: isComplete ? _scaleAnimation.value : 1.0,
                  child: Container(
                    height: 56,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: isComplete
                          ? LinearGradient(
                        colors: [
                          ArgieColors.primary,
                          ArgieColors.secondary,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                          : null,
                      color: isComplete ? null : backgroundColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () => _showValidationDialog(context, missingMessage),
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (isComplete) ...[
                                Icon(
                                  Icons.analytics,
                                  color: textColor,
                                  size: 24,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'Analyze Results',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: textColor,
                                  ),
                                ),
                              ] else ...[
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        value: totalProgress,
                                        strokeWidth: 2,
                                        backgroundColor: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
                                        valueColor: AlwaysStoppedAnimation(
                                          isDarkMode ? Colors.grey.shade400 : Colors.grey.shade500,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '${(totalProgress * 100).toInt()}%',
                                      style: GoogleFonts.poppins(
                                        fontSize: 8,
                                        fontWeight: FontWeight.bold,
                                        color: textColor,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'Complete Required Data',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: textColor,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator({
    required String label,
    required double progress,
    required IconData icon,
    required Color color,
    required bool isDarkMode,
  }) {
    final bool isComplete = progress >= 1.0;

    return Column(
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: isComplete ? color : isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
              size: 16,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade700,
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: isComplete
                    ? color.withValues(alpha: 0.2)
                    : isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${(progress * 100).toInt()}%',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isComplete
                      ? color
                      : isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 6,
            backgroundColor: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
            valueColor: AlwaysStoppedAnimation(isComplete ? color : color.withValues(alpha: 0.5)),
          ),
        ),
      ],
    );
  }
}