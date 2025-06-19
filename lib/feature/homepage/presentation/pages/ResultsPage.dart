import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:swine_care/colors/ArgieColors.dart';
import 'package:swine_care/colors/ArgieSizes.dart';
import 'package:swine_care/data/model/Prediction.dart';

class ResultsPage extends StatefulWidget {
  final Map<String, File?> uploadedImages;
  final Map<String, bool?> symptoms;
  final List<Prediction>? earsPredictions;
  final List<Prediction>? skinPredictions;

  const ResultsPage({
    super.key,
    required this.uploadedImages,
    required this.symptoms,
    this.earsPredictions,
    this.skinPredictions,
  });

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  bool _showAnimation = true;

  @override
  void initState() {
    super.initState();

    // for debug na ma print sa console para makita ang confidence scores

    print('--- Results Page Loaded ---');
    print('Uploaded Images: ${widget.uploadedImages.map((k, v) => MapEntry(k, v?.path ?? 'null'))}');
    print('Symptoms: ${widget.symptoms}'); // Debug
    if (widget.earsPredictions != null && widget.earsPredictions!.isNotEmpty) {
      print('--- Ears Predictions ---');
      for (var prediction in widget.earsPredictions!) {
        print('Prediction: ${prediction.prediction}, Confidence Score: ${(prediction.confidence_score * 100).toStringAsFixed(1)}%');
      }
    } else {
      print('No Ears Predictions Available');
    }
    if (widget.skinPredictions != null && widget.skinPredictions!.isNotEmpty) {
      print('--- Skin Predictions ---');
      for (var prediction in widget.skinPredictions!) {
        print('Prediction: ${prediction.prediction}, Confidence Score: ${(prediction.confidence_score * 100).toStringAsFixed(1)}%');
      }
    } else {
      print('No Skin Predictions Available');
    }

    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) setState(() => _showAnimation = false);
    });
  }

  String analyzeASF() {
    // Image Analysis Score (60% weight)
    double imageScore = 0;
    double maxImageScore = 0;

    // Calculate image scores
    if (widget.earsPredictions != null && widget.earsPredictions!.isNotEmpty) {
      double earsConfidence = widget.earsPredictions!.first.confidence_score;
      imageScore += earsConfidence * 30; // 30% for ears
      maxImageScore += 30;
      debugPrint('Ears Image Score: ${earsConfidence * 30}');
    }

    if (widget.skinPredictions != null && widget.skinPredictions!.isNotEmpty) {
      double skinConfidence = widget.skinPredictions!.first.confidence_score;
      imageScore += skinConfidence * 30; // 30% for skin
      maxImageScore += 30;
      debugPrint('Skin Image Score: ${skinConfidence * 30}');
    }

    // Normalize image score to percentage
    double imagePercentage = maxImageScore > 0 ? (imageScore / maxImageScore) * 100 : 0;
    debugPrint('Image Analysis Percentage: ${imagePercentage.toStringAsFixed(1)}%');

    // Symptom Score (40% weight)
    int symptomScore = 0;
    int totalSymptoms = widget.symptoms.length;
    int positiveSymptoms = 0;

    // Calculate symptom scores
    widget.symptoms.forEach((symptom, answer) {
      if (answer == true) {
        symptomScore += 1;
        positiveSymptoms++;
        debugPrint('Symptom $symptom: true, Score: 1');
      } else {
        debugPrint('Symptom $symptom: ${answer ?? 'null'}, Score: 0');
      }
    });

    // Normalize symptom score to percentage (40% total weight)
    double symptomPercentage = (symptomScore / totalSymptoms) * 40;
    debugPrint('Symptom Score: $symptomScore out of $totalSymptoms');
    debugPrint('Symptom Percentage: ${symptomPercentage.toStringAsFixed(1)}%');

    // Calculate final weighted score
    double finalScore = imagePercentage + symptomPercentage;
    debugPrint('Final Weighted Score: ${finalScore.toStringAsFixed(1)}%');

    // Determine risk level based on final score
    if (finalScore >= 70 || (imagePercentage >= 50 && positiveSymptoms >= 3)) {
      return "Highly Likely";
    } else if (finalScore >= 40 || (imagePercentage >= 30 && positiveSymptoms >= 2)) {
      return "Medium Likelihood";
    } else {
      return "Low Risk";
    }
  }

  List<String> getRecommendations(String likelihood) {
    switch (likelihood) {
      case "Highly Likely":
        return [
          "Immediately isolate the affected pig(s)",
          "Contact a veterinarian urgently",
          "Implement strict biosecurity measures",
          "Monitor other pigs for similar symptoms",
          "Document all symptoms and changes"
        ];
      case "Medium Likelihood":
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
                  "No $title predictions available. Please ensure images clearly show symptoms or check API configuration.",
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
                  "$title Predictions",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white70 : Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: ArgieSizes.spaceBtwItems),
            ...predictions.map((p) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      p.prediction,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: isDarkMode ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                  Text(
                    "Confidence: ${(p.confidence_score * 100).toStringAsFixed(1)}%",
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: p.confidence_score > 0.7
                          ? Colors.red
                          : p.confidence_score > 0.4
                          ? Colors.orange
                          : Colors.green,
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

  @override
  Widget build(BuildContext context) {
    final String likelihood = analyzeASF();
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
              'Analyzing Your Data... Please Wait',
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
              padding: const EdgeInsets.all(ArgieSizes.paddingDefault),
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
                  const SizedBox(height: ArgieSizes.spaceBtwSections),

                  // Confidence Scores Section
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
                              color: likelihood == "Highly Likely"
                                  ? Colors.red.shade100
                                  : likelihood == "Medium Likelihood"
                                  ? Colors.orange.shade100
                                  : Colors.green.shade100,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: likelihood == "Highly Likely"
                                    ? Colors.red.shade300
                                    : likelihood == "Medium Likelihood"
                                    ? Colors.orange.shade300
                                    : Colors.green.shade300,
                              ),
                            ),
                            child: Text(
                              likelihood,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: likelihood == "Highly Likely"
                                    ? Colors.red.shade700
                                    : likelihood == "Medium Likelihood"
                                    ? Colors.orange.shade700
                                    : Colors.green.shade700,
                              ),
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
                  Center(
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}