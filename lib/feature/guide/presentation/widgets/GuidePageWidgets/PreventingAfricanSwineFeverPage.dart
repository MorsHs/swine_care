import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swine_care/feature/guide/presentation/widgets/BackButton.dart';

class PreventingAfricanSwineFeverPage extends StatelessWidget {
  const PreventingAfricanSwineFeverPage({super.key});

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
            _buildSectionHeader("Understanding ASF"),
            const SizedBox(height: 10),

            // Content for Understanding ASF
            _buildDescription(
              "African Swine Fever (ASF) is a highly contagious viral disease that affects pigs. It has no cure or vaccine, making prevention critical.\n\n"
                  "Key Characteristics:\n"
                  "• High fever (>40°C)\n"
                  "• Loss of appetite\n"
                  "• Blueish ears and skin discoloration\n"
                  "• Sudden death in severe cases",
            ),
            const SizedBox(height: 20),

            // Section Header
            _buildSectionHeader("Prevention Strategies"),
            const SizedBox(height: 10),

            // Content for Prevention Strategies
            _buildDescription(
              "1. Biosecurity Measures:\n"
                  "• Restrict farm access to authorized personnel only.\n"
                  "• Implement footbaths with disinfectants at entry points.\n"
                  "• Avoid feeding pigs with kitchen waste or contaminated food.\n\n"
                  "2. Isolation Protocols:\n"
                  "• Quarantine new pigs for at least 30 days before introducing them to the herd.\n"
                  "• Immediately isolate sick pigs and contact a veterinarian.\n\n"
                  "3. Hygiene Practices:\n"
                  "• Clean and disinfect pens daily.\n"
                  "• Dispose of pig waste properly to prevent contamination.\n\n"
                  "4. Monitoring and Reporting:\n"
                  "• Regularly check pigs for symptoms of ASF.\n"
                  "• Report suspected cases to local authorities immediately.",
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
          colors: [Color(0xff91ef72), Color(0xff38ec87)],
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
            "Pro Tips for ASF Prevention",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          _buildTipItem(Icons.check_circle, "Train workers on biosecurity protocols."),
          _buildTipItem(Icons.check_circle, "Regularly update your knowledge about ASF."),
          _buildTipItem(Icons.check_circle, "Use protective clothing when handling pigs."),
          _buildTipItem(Icons.check_circle, "Avoid sharing equipment with other farms."),
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