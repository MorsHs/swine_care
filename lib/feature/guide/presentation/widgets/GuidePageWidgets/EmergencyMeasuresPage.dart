import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swine_care/feature/guide/presentation/widgets/BackButton.dart';

class EmergencyMeasuresPage extends StatelessWidget {
  const EmergencyMeasuresPage({super.key});

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
            _buildSectionHeader("Immediate Actions During an Outbreak"),
            const SizedBox(height: 10),

            // Content for Immediate Actions
            _buildDescription(
              "When a disease outbreak occurs, quick and decisive actions are critical to minimize losses:\n\n"
                  "1. Isolate Affected Pigs:\n"
                  "• Separate sick pigs from the herd immediately.\n"
                  "• Place them in a quarantine area to prevent further spread.\n\n"
                  "2. Contact Authorities:\n"
                  "• Report suspected cases to local veterinary services or authorities.\n"
                  "• Follow their guidance on containment and disposal.\n\n"
                  "3. Restrict Farm Access:\n"
                  "• Limit entry to authorized personnel only.\n"
                  "• Implement strict biosecurity measures at all entry points.",
            ),
            const SizedBox(height: 20),

            // Section Header
            _buildSectionHeader("Emergency Protocols"),
            const SizedBox(height: 10),

            // Content for Emergency Protocols
            _buildDescription(
              "1. Disinfection Procedures:\n"
                  "• Clean and disinfect pens, equipment, and vehicles daily.\n"
                  "• Use approved disinfectants like potassium peroxymonosulfate.\n\n"
                  "2. Monitor Symptoms:\n"
                  "• Check all pigs regularly for signs of illness (e.g., fever, lethargy).\n"
                  "• Record observations and share them with veterinarians.\n\n"
                  "3. Cull Infected Animals:\n"
                  "• In severe outbreaks, culling may be necessary to stop the spread.\n"
                  "• Dispose of carcasses safely following local regulations.\n\n"
                  "Warning: Do not attempt to treat ASF-infected pigs as there is no cure.",
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
          colors: [Color(0xffb0b422), Color(0xffd9d367)],
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
            "Pro Tips for Emergency Situations",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          _buildTipItem(Icons.check_circle, "Act quickly to isolate sick pigs."),
          _buildTipItem(Icons.check_circle, "Keep emergency contact numbers handy."),
          _buildTipItem(Icons.check_circle, "Train workers on emergency protocols."),
          _buildTipItem(Icons.check_circle, "Dispose of waste safely to avoid contamination."),
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