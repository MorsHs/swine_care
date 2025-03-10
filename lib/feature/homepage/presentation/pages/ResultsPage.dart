import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:swine_care/colors/ArgieColors.dart';
import 'package:swine_care/colors/ArgieSizes.dart';

class ResultsPage extends StatefulWidget {
  final Map<String, File?> uploadedImages;
  final Map<String, bool?> symptoms;

  const ResultsPage({super.key, required this.uploadedImages, required this.symptoms});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  bool _showAnimation = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) setState(() => _showAnimation = false);
    });
  }

  String analyzeASF() {
    int riskScore = 0;
    int totalSymptoms = widget.symptoms.length;
    int totalImages = widget.uploadedImages.length;
    widget.uploadedImages.forEach((part, image) => riskScore += image == null ? 2 : 1);
    int positiveSymptoms = 0;
    widget.symptoms.forEach((symptom, answer) {
      if (answer == true) {
        riskScore += 3;
        positiveSymptoms++;
      }
    });
    double riskPercentage = (riskScore / ((totalImages * 2) + (totalSymptoms * 3))) * 100;
    if (riskPercentage >= 70 || positiveSymptoms >= 4) return "Highly Likely";
    if (riskPercentage >= 40 || positiveSymptoms >= 2) return "Medium Likelihood";
    return "Low Risk";
  }

  List<String> getRecommendations(String likelihood) {
    switch (likelihood) {
      case "Highly Likely":
        return [
          "Immediately isolate the affected pig(s)",
          "Contact a veterinarian urgently",
          "Implement biosecurity measures",
          "Monitor other pigs"
        ];
      case "Medium Likelihood":
        return [
          "Monitor the pig for 24-48 hours",
          "Maintain hygiene protocols",
          "Consult a veterinarian",
          "Prepare for isolation"
        ];
      default:
        return [
          "Continue health monitoring",
          "Maintain hygiene",
          "Record changes",
          "Schedule check-up"
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final String likelihood = analyzeASF();
    final List<String> recommendations = getRecommendations(likelihood);
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      bottomNavigationBar: null, // Explicitly hide the bottom navigation bar
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
                          color: ArgieColors.textthird,
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