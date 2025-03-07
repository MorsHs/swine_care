import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class ResultsPage extends StatefulWidget {
  final Map<String, File?> uploadedImages;
  final Map<String, bool?> symptoms;

  const ResultsPage({
    super.key,
    required this.uploadedImages,
    required this.symptoms,
  });

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  bool _showAnimation = true;

  @override
  void initState() {
    super.initState();
    // Hide animation after 4 seconds
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _showAnimation = false;
        });
      }
    });
  }

  // Enhanced ASF analysis with more detailed scoring
  String analyzeASF() {
    int riskScore = 0;
    int totalSymptoms = widget.symptoms.length;
    int totalImages = widget.uploadedImages.length;

    // Image analysis (more weight if images are missing)
    widget.uploadedImages.forEach((part, image) {
      if (image == null) {
        riskScore += 2; // Higher penalty for missing images
      } else {
        riskScore += 1; // Small risk even with images
      }
    });

    // Symptom analysis
    int positiveSymptoms = 0;
    widget.symptoms.forEach((symptom, answer) {
      if (answer == true) {
        riskScore += 3; // More weight for positive symptoms
        positiveSymptoms++;
      }
    });

    // Calculate percentage of positive indicators
    double riskPercentage = (riskScore / ((totalImages * 2) + (totalSymptoms * 3))) * 100;

    if (riskPercentage >= 70 || positiveSymptoms >= 4) {
      return "Highly Likely";
    } else if (riskPercentage >= 40 || positiveSymptoms >= 2) {
      return "Medium Likelihood";
    } else {
      return "Low Risk";
    }
  }

  List<String> getRecommendations(String likelihood) {
    switch (likelihood) {
      case "Highly Likely":
        return [
          "Immediately isolate the affected pig(s) to prevent spread",
          "Contact a veterinarian urgently for professional diagnosis",
          "Implement strict biosecurity measures and disinfect the area",
          "Monitor other pigs for similar symptoms"
        ];
      case "Medium Likelihood":
        return [
          "Closely monitor the pig for 24-48 hours",
          "Maintain strict hygiene protocols",
          "Consult a veterinarian for a professional opinion",
          "Prepare for potential isolation if symptoms worsen"
        ];
      default: // Low Risk
        return [
          "Continue regular health monitoring",
          "Maintain good hygiene and nutrition practices",
          "Record any changes in behavior or appearance",
          "Schedule routine veterinary check-up"
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final String likelihood = analyzeASF();
    final List<String> recommendations = getRecommendations(likelihood);

    return Scaffold(
      body: _showAnimation
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/Animations/ResultAnimation.json',
              width: 300,
              height: 300,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            Text(
              'Analyzing Your Data... Please Wait',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
      )
          : CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "Diagnostic Results",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [Shadow(color: Colors.black45, blurRadius: 2)],
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.green.shade700,
                      Colors.green.shade300,
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Result Card
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.analytics,
                                color: Colors.green.shade700,
                                size: 28,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                "ASF Likelihood",
                                style: GoogleFonts.poppins(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
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

                  const SizedBox(height: 24),

                  // Recommendations Section
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.recommend,
                                color: Colors.green.shade700,
                                size: 24,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                "Recommended Actions",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ...recommendations.map((recommendation) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.green.shade600,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      recommendation,
                                      style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        color: Colors.black87,
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Back Button
                  Center(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade700,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 12,
                        ),
                      ),
                      child: Text(
                        "Back to Home",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
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