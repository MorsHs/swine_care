import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:swine_care/colors/ArgieColors.dart';
import 'package:swine_care/colors/ArgieSizes.dart';
import 'package:swine_care/data/model/Prediction.dart';
import 'package:swine_care/data/repositories/HistoryRepository.dart';
import 'package:swine_care/data/repositories/DatabaseImage.dart';

class ResultsPage extends StatefulWidget {
  final Map<String, File?> uploadedImages;
  final Map<String, Uint8List?> webImages;
  final Map<String, bool> symptoms;
  final List<Prediction>? earsPredictions;
  final List<Prediction>? skinPredictions;

  const ResultsPage({
    super.key,
    required this.uploadedImages,
    required this.webImages,
    required this.symptoms,
    this.earsPredictions,
    this.skinPredictions,
  });

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  bool _showAnimation = true;
  final HistoryRepository _historyRepository = HistoryRepository();
  final DatabaseImageSender _databaseImageSender = DatabaseImageSender();

  @override
  void initState() {
    super.initState();

    // Debugggggggggggggg rani ya
    debugPrint('--- Results Page Loaded ---');
    debugPrint('Uploaded Images: ${widget.uploadedImages.map((k, v) => MapEntry(k, v?.path ?? 'null'))}');
    debugPrint('Web Images: ${widget.webImages.map((k, v) => MapEntry(k, v != null ? '${v.length} bytes' : 'null'))}');
    debugPrint('Symptoms: ${widget.symptoms}');
    if (widget.earsPredictions != null && widget.earsPredictions!.isNotEmpty) {
      debugPrint('--- Ears Predictions ---');
      for (var prediction in widget.earsPredictions!) {
        debugPrint('Prediction: ${prediction.prediction}, Confidence Score: ${(prediction.confidence_score * 100).toStringAsFixed(1)}%');
      }
    } else {
      debugPrint('No Ears Predictions Available');
    }
    if (widget.skinPredictions != null && widget.skinPredictions!.isNotEmpty) {
      debugPrint('--- Skin Predictions ---');
      for (var prediction in widget.skinPredictions!) {
        debugPrint('Prediction: ${prediction.prediction}, Confidence Score: ${(prediction.confidence_score * 100).toStringAsFixed(1)}%');
      }
    } else {
      debugPrint('No Skin Predictions Available');
    }

    // Automatically save diagnostic data to database after a short delay to ensure widget is fully initialized
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        debugPrint('Starting automatic database save...');
        _saveDiagnosticToDatabase();
      }
    });

    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) setState(() => _showAnimation = false);
    });
  }

  // Method to automatically save diagnostic data to database
  Future<void> _saveDiagnosticToDatabase() async {
    try {
      debugPrint('=== Starting Database Save Process ===');

      // Get diagnostic analysis
      final (String likelihood, double finalScore) = analyzeASF();
      final List<String> recommendations = getRecommendations(likelihood);

      debugPrint('Analysis completed - Diagnosis: $likelihood, Score: $finalScore');

      // Generate a pig ID
      final String pigId = 'PIG-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}';
      debugPrint('Generated Pig ID: $pigId');

      // Get images
      final File? earsImage = widget.uploadedImages['Ears'];
      final File? skinImage = widget.uploadedImages['Skin'];

      debugPrint('Images status - Ears: ${earsImage != null ? 'Available' : 'Missing'}, Skin: ${skinImage != null ? 'Available' : 'Missing'}');
      debugPrint('Ears predictions count: ${widget.earsPredictions?.length ?? 0}');
      debugPrint('Skin predictions count: ${widget.skinPredictions?.length ?? 0}');

      // Save simplified diagnostic data to database (for admin/analysis)
      await _databaseImageSender.saveDiagnosticData(
        earsImage: widget.uploadedImages['Ears'],
        skinImage: widget.uploadedImages['Skin'],
        webEarsImage: widget.webImages['Ears'],
        webSkinImage: widget.webImages['Skin'],
        earsPredictions: widget.earsPredictions,
        skinPredictions: widget.skinPredictions,
        diagnosis: likelihood,
        finalScore: finalScore,
        pigId: pigId,
      );

      // Also save to history collection (for user's history page)
      final record = _historyRepository.createRecord(
        pigId: pigId,
        diagnosis: likelihood,
        finalScore: finalScore,
        symptoms: widget.symptoms,
        earsPredictions: widget.earsPredictions ?? [],
        skinPredictions: widget.skinPredictions ?? [],
        recommendations: recommendations,
      );

      await _historyRepository.addRecord(record);

      debugPrint('✅ Diagnostic data saved to both database and history successfully');
      debugPrint('=== Database Save Process Completed ===');
    } catch (e) {
      debugPrint('❌ Error saving diagnostic data to database: $e');
      debugPrint('Error details: ${e.toString()}');
      // Don't show error to user as this is automatic background save
    }
  }

  (String likelihood, double finalScore) analyzeASF() {
    double getPartScore(List<Prediction>? predictions) {
      if (predictions == null || predictions.isEmpty) return 0.0;
      // Prioritize 'asf', then 'unhealthy', then 'infected', else healthy
      Prediction? highestRisk;
      for (var label in ['asf', 'unhealthy', 'infected']) {
        highestRisk = predictions
            .where((p) => p.prediction.toLowerCase() == label)
            .fold<Prediction?>(null, (prev, p) =>
        (prev == null || p.confidence_score > prev.confidence_score) ? p : prev);
        if (highestRisk != null) break;
      }
      // If no risky label, use the highest-confidence healthy prediction
      if (highestRisk == null) {
        highestRisk = predictions.fold<Prediction?>(null, (prev, p) =>
        (prev == null || p.confidence_score > prev.confidence_score) ? p : prev);
      }
      // Only risky labels contribute to risk score
      if (highestRisk != null &&
          (highestRisk.prediction.toLowerCase() == 'asf' ||
              highestRisk.prediction.toLowerCase() == 'unhealthy' ||
              highestRisk.prediction.toLowerCase() == 'infected')) {
        return highestRisk.confidence_score;
      }
      return 0.0;
    }

    // Ears (30%)
    double earsScore = getPartScore(widget.earsPredictions) * 30;
    // Skin (30%)
    double skinScore = getPartScore(widget.skinPredictions) * 30;
    // Image total (60%)
    double imageScore = earsScore + skinScore;

    // Symptoms (40%)
    int symptomScore = 0;
    int totalSymptoms = widget.symptoms.length;
    widget.symptoms.forEach((_, answer) {
      if (answer == true) symptomScore += 1;
    });
    double symptomPercentage = totalSymptoms > 0 ? (symptomScore / totalSymptoms) * 40 : 0;

    // Final weighted score
    double finalScore = imageScore + symptomPercentage;

    // Risk thresholds
    String likelihood;
    if (finalScore >= 80) {
      likelihood = "High Risk";
    } else if (finalScore >= 55) {
      likelihood = "Medium Risk";
    } else {
      likelihood = "Low Risk";
    }

    // Debug output
    debugPrint('Ears Score: $earsScore/30');
    debugPrint('Skin Score: $skinScore/30');
    debugPrint('Image Score: $imageScore/60');
    debugPrint('Symptom Score: $symptomScore/$totalSymptoms');
    debugPrint('Symptom Percentage: $symptomPercentage/40');
    debugPrint('Final Weighted Score: $finalScore/100');
    debugPrint('Risk Level: $likelihood');

    return (likelihood, finalScore);
  }

  List<String> getRecommendations(String likelihood) {
    switch (likelihood) {
      case "High Risk":
        return [
          "Immediately isolate the affected pig(s)",
          "Contact a veterinarian urgently",
          "Implement strict biosecurity measures",
          "Monitor other pigs for similar symptoms",
          "Document all symptoms and changes"
        ];
      case "Medium Risk":
        return [
          "Monitor the pig for 24-48 hours",
          "Maintain strict hygiene protocols",
          "Consult a veterinarian for assessment",
          "Prepare isolation facilities",
          "Document any changes in symptoms"
        ];
      default:
        return [
          "Continue regular health monitoring",
          "Maintain standard hygiene practices",
          "Record any changes in behavior or appearance",
          "Schedule routine veterinary check-up",
          "Keep detailed health records"
        ];
    }
  }

  Widget _buildPredictionsList(String title, List<Prediction>? predictions, bool isDarkMode) {
    if (predictions == null || predictions.isEmpty) {
      return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: isDarkMode ? Colors.grey[800] : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(ArgieSizes.paddingDefault),
          child: Row(
            children: [
              Icon(
                title.toLowerCase().contains('ears') ? Icons.hearing : Icons.medical_services,
                color: Colors.orange,
                size: 24,
              ),
              const SizedBox(width: ArgieSizes.spaceBtwWidgets),
              Expanded(
                child: Text(
                  "$title not detected (upload clear images to have accurate diagnosis.",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: isDarkMode ? Colors.white70 : Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Priority: infected > unhealthy > healthy
    Prediction? displayPrediction;
    String displayLabel = '';
    for (var label in ['infected', 'asf', 'unhealthy', 'healthy']) {
      displayPrediction = predictions
          .where((p) => p.prediction.toLowerCase() == label)
          .fold<Prediction?>(null, (prev, p) =>
      (prev == null || p.confidence_score > prev.confidence_score) ? p : prev);
      if (displayPrediction != null) {
        if (label == 'infected' || label == 'asf') {
          displayLabel = 'Infected';
        } else if (label == 'unhealthy') {
          displayLabel = 'Unhealthy';
        } else if (label == 'healthy') {
          displayLabel = 'Healthy';
        }
        break;
      }
    }

    if (displayPrediction == null) {
      // fallback: show highest-confidence prediction
      displayPrediction = predictions.fold<Prediction?>(null, (prev, p) =>
      (prev == null || p.confidence_score > prev.confidence_score) ? p : prev);
      if (displayPrediction?.prediction.toLowerCase() == 'not infected') {
        displayLabel = 'Healthy';
      } else {
        displayLabel = displayPrediction?.prediction ?? '';
      }
    }

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: isDarkMode ? Colors.grey[800] : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(ArgieSizes.paddingDefault),
        child: Row(
          children: [
            Icon(
              title.toLowerCase().contains('ears') ? Icons.hearing : Icons.medical_services,
              color: ArgieColors.primary,
              size: 24,
            ),
            const SizedBox(width: ArgieSizes.spaceBtwWidgets),
            Expanded(
              child: Text(
                '$displayLabel, Confidence: ${(displayPrediction!.confidence_score * 100).toStringAsFixed(1)}%',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: isDarkMode ? Colors.white : Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSymptomsSummary(bool isDarkMode) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: isDarkMode ? Colors.grey[800] : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(ArgieSizes.paddingDefault),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.checklist,
                  color: ArgieColors.primary,
                  size: 24,
                ),
                const SizedBox(width: ArgieSizes.spaceBtwWidgets),
                Text(
                  "Symptoms Reported",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white70 : Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: ArgieSizes.spaceBtwItems),
            ...widget.symptoms.entries.map((entry) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      entry.key,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: isDarkMode ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                  Text(
                    entry.value == true
                        ? "Yes"
                        : entry.value == false
                        ? "No"
                        : "Not Answered",
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: entry.value == true
                          ? Colors.red
                          : entry.value == false
                          ? Colors.green
                          : Colors.grey,
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePreview(String title, File? image, Uint8List? webImage, bool isDarkMode) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: isDarkMode ? Colors.grey[800] : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(ArgieSizes.paddingDefault),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  title.toLowerCase().contains('ears') ? Icons.hearing : Icons.medical_services,
                  color: ArgieColors.primary,
                  size: 24,
                ),
                const SizedBox(width: ArgieSizes.spaceBtwWidgets),
                Text(
                  "$title Image",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white70 : Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: ArgieSizes.spaceBtwItems),
            if (image != null || webImage != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: kIsWeb && webImage != null
                    ? Image.memory(
                  webImage,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
                    : image != null
                    ? Image.file(
                  image,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
                    : Container(),
              )
            else
              Text(
                "No $title image uploaded",
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: isDarkMode ? Colors.white70 : Colors.black87,
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final (String likelihood, double finalScore) = analyzeASF();
    final List<String> recommendations = getRecommendations(likelihood);
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      bottomNavigationBar: null,
      body: _showAnimation
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/Animations/ResultAnimation.json',
              width: 300,
              height: 300,
            ),
            const SizedBox(height: ArgieSizes.spaceBtwSections),
            Text(
              'Analyzing your data, please wait..',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade700,
              ),
            ),
          ],
        ),
      )
          : CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Diagnostic Results",
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : ArgieColors.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Uploaded Images",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white70 : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: ArgieSizes.spaceBtwItems),
                  _buildImagePreview("Ears", widget.uploadedImages['Ears'], widget.webImages['Ears'], isDarkMode),
                  const SizedBox(height: ArgieSizes.spaceBtwItems),
                  _buildImagePreview("Skin", widget.uploadedImages['Skin'], widget.webImages['Skin'], isDarkMode),
                  const SizedBox(height: ArgieSizes.spaceBtwSections),

                  // Detection Results
                  Text(
                    "Detection Results",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white70 : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: ArgieSizes.spaceBtwItems),
                  _buildPredictionsList("Ears", widget.earsPredictions, isDarkMode),
                  const SizedBox(height: ArgieSizes.spaceBtwItems),
                  _buildPredictionsList("Skin", widget.skinPredictions, isDarkMode),
                  const SizedBox(height: ArgieSizes.spaceBtwSections),

                  // Symptoms Summary
                  Text(
                    "Symptoms Summary",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white70 : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: ArgieSizes.spaceBtwItems),
                  _buildSymptomsSummary(isDarkMode),
                  const SizedBox(height: ArgieSizes.spaceBtwSections),

                  // ASF Likelihood Card
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    color: isDarkMode ? Colors.grey[800] : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(ArgieSizes.paddingDefault),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.analytics,
                                color: ArgieColors.primary,
                                size: 28,
                              ),
                              const SizedBox(width: ArgieSizes.spaceBtwWidgets),
                              Text(
                                "ASF Likelihood",
                                style: GoogleFonts.poppins(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: isDarkMode ? Colors.white70 : Colors.black87,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: ArgieSizes.spaceBtwItems),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(ArgieSizes.spaceBtwItems),
                            decoration: BoxDecoration(
                              color: likelihood == "High Risk"
                                  ? Colors.red.shade100
                                  : likelihood == "Medium Risk"
                                  ? Colors.orange.shade100
                                  : Colors.green.shade100,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: likelihood == "High Risk"
                                    ? Colors.red.shade300
                                    : likelihood == "Medium Risk"
                                    ? Colors.orange.shade300
                                    : Colors.green.shade300,
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  likelihood,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: likelihood == "High Risk"
                                        ? Colors.red.shade700
                                        : likelihood == "Medium Risk"
                                        ? Colors.orange.shade700
                                        : Colors.green.shade700,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Final Weighted Score: ${finalScore.toStringAsFixed(1)}%',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: isDarkMode ? Colors.white70 : Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '(60% Image Detection, 40% Symptoms)',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: ArgieSizes.spaceBtwSections),

                  // Recommendations Card
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    color: isDarkMode ? Colors.grey[800] : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(ArgieSizes.paddingDefault),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.recommend,
                                color: ArgieColors.primary,
                                size: 24,
                              ),
                              const SizedBox(width: ArgieSizes.spaceBtwWidgets),
                              Text(
                                "Recommended Actions",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isDarkMode ? Colors.white70 : Colors.black87,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: ArgieSizes.spaceBtwItems),
                          ...recommendations.map((rec) => Padding(
                            padding: const EdgeInsets.only(bottom: ArgieSizes.spaceBtwWidgets / 2),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.check_circle_outline,
                                  color: ArgieColors.primary,
                                  size: 18,
                                ),
                                const SizedBox(width: ArgieSizes.spaceBtwWidgets),
                                Expanded(
                                  child: Text(
                                    rec,
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      color: isDarkMode ? Colors.white70 : Colors.black87,
                                      height: 1.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: ArgieSizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => context.go('/homepage'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ArgieColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: ArgieSizes.paddingDefault,
                          vertical: ArgieSizes.spaceBtwItems,
                        ),
                      ),
                      child: Text(
                        "Back to Home",
                        style: GoogleFonts.poppins(
                          color: Colors.grey.shade300,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}