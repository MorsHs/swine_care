import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultsPage extends StatelessWidget {
  // Simulated data for analysis
  final Map<String, File?> uploadedImages;
  final Map<String, bool?> symptoms;

  const ResultsPage({
    super.key,
    required this.uploadedImages,
    required this.symptoms,
  });

  // Analyze the likelihood of ASF
  String analyzeASF() {
    int riskScore = 0;

    // Check uploaded images
    uploadedImages.forEach((part, image) {
      if (image == null) {
        riskScore += 1; // Penalize missing images
      }
    });

    // Check symptoms
    symptoms.forEach((symptom, answer) {
      if (answer == true) {
        riskScore += 2; // Each "Yes" increases the risk score
      }
    });

    // Determine likelihood based on risk score
    if (riskScore >= 8) {
      return "Highly Likely";
    } else if (riskScore >= 4) {
      return "Medium Likelihood";
    } else {
      return "Rare Likelihood";
    }
  }

  // Get recommendations based on the likelihood
  List<String> getRecommendations(String likelihood) {
    switch (likelihood) {
      case "Highly Likely":
        return [
          "Isolate the affected pig immediately.",
          "Contact a veterinarian for further diagnosis.",
          "Disinfect the farm and equipment thoroughly."
        ];
      case "Medium Likelihood":
        return [
          "Monitor the pig closely for worsening symptoms.",
          "Ensure proper hygiene and nutrition.",
          "Consult a veterinarian if symptoms persist."
        ];
      default: // Rare Likelihood
        return [
          "Continue regular monitoring of the pig.",
          "Maintain cleanliness and proper feeding practices.",
          "No immediate action required unless symptoms develop."
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final String likelihood = analyzeASF();
    final List<String> recommendations = getRecommendations(likelihood);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Analysis Results",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green.shade300,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            // Title
            Text(
              "Likelihood of ASF",
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),

            // Likelihood Result
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: likelihood == "Highly Likely"
                    ? Colors.red[100]
                    : likelihood == "Medium Likelihood"
                    ? Colors.orange[100]
                    : Colors.green[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                likelihood,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: likelihood == "Highly Likely"
                      ? Colors.red
                      : likelihood == "Medium Likelihood"
                      ? Colors.orange
                      : Colors.green,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Recommendations
            Text(
              "Recommendations:",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            ...recommendations.map((recommendation) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.check_circle, color: Colors.green, size: 16),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        recommendation,
                        style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}