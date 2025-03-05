import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swine_care/feature/guide/presentation/widgets/BackButton.dart';

class BestPracticesPage extends StatelessWidget {
  const BestPracticesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back Button and Heart Button
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackButtonToGuidePage(),

              ],
            ),
            const SizedBox(height: 20),

            // Section Header
            _buildSectionHeader("Starting a Swine Farm"),
            const SizedBox(height: 10),

            // Content for Starting a Swine Farm
            _buildDescription(
              "1. Choose the Right Location:\n"
                  "• Ensure good drainage and access to clean water.\n"
                  "• Avoid areas prone to flooding or extreme weather.\n\n"
                  "2. Select Healthy Breeds:\n"
                  "• Start with disease-resistant breeds like Landrace or Duroc.\n"
                  "• Purchase pigs from reputable breeders.\n\n"
                  "3. Build Proper Infrastructure:\n"
                  "• Construct pens with adequate space (4m² per adult pig).\n"
                  "• Include proper ventilation and waste management systems.",
            ),
            const SizedBox(height: 20),

            // Section Header
            _buildSectionHeader("Managing a Swine Farm"),
            const SizedBox(height: 10),

            // Content for Managing a Swine Farm
            _buildDescription(
              "1. Daily Feeding Routine:\n"
                  "• Provide balanced feed based on the pigs' growth stage.\n"
                  "• Monitor water supply and cleanliness.\n\n"
                  "2. Disease Prevention:\n"
                  "• Vaccinate regularly against common diseases (e.g., hog cholera).\n"
                  "• Quarantine new pigs for 30 days before introducing them to the herd.\n\n"
                  "3. Hygiene and Sanitation:\n"
                  "• Clean pens daily and disinfect weekly.\n"
                  "• Implement footbaths for workers and visitors.\n\n"
                  "4. Monitoring Growth:\n"
                  "• Track weight gain and health indicators.\n"
                  "• Use technology (e.g., apps) to record data and detect issues early.",
            ),
            const SizedBox(height: 20),

            // Tips Section
            _buildTipsSection(),
          ],
        ),
      ),
    );
  }

  // Helper Method: Build Section Headers
  Widget _buildSectionHeader(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xff6baed7), Color(0xff7cdfec)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  // Helper Method: Build Description Text
  Widget _buildDescription(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text.rich(
        TextSpan(
          style: GoogleFonts.poppins(fontSize: 16, color: Colors.black87),
          children: [
            ...text.split('\n').map((line) {
              if (line.startsWith('•') || line.startsWith('Warning')) {
                return TextSpan(
                  text: '$line\n',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                );
              } else if (line.startsWith('Example')) {
                return TextSpan(
                  text: '$line\n',
                  style: GoogleFonts.poppins(
                    fontStyle: FontStyle.italic,
                    color: Colors.green,
                  ),
                );
              } else {
                return TextSpan(text: '$line\n');
              }
            }).toList(),
          ],
        ),
      ),
    );
  }

  // Helper Method: Build Tips Section
  Widget _buildTipsSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Pro Tips for Success",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          _buildTipItem(Icons.check_circle, "Start small and scale gradually."),
          _buildTipItem(Icons.check_circle, "Train workers on hygiene protocols."),
          _buildTipItem(Icons.check_circle, "Use technology for monitoring and record-keeping."),
          _buildTipItem(Icons.check_circle, "Consult veterinarians regularly for advice."),
        ],
      ),
    );
  }

  // Helper Method: Build Individual Tip Items
  Widget _buildTipItem(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.green, size: 18),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
          ),
        ),
      ],
    );
  }
}