import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swine_care/colors/ArgieColors.dart';
import 'package:url_launcher/url_launcher.dart';

class PreventingAfricanSwineFeverPage extends StatelessWidget {
  const PreventingAfricanSwineFeverPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.grey[850] : const Color(0xfff5f7f2),
      appBar: AppBar(
        backgroundColor: ArgieColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go('/guide'),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark_outline, color: isDarkMode ? Colors.white : const Color(0xfff5f7f2)),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Saved to Favorites!",
                    style: TextStyle(color: isDarkMode ? Colors.white : Colors.black87),
                  ),
                  backgroundColor: isDarkMode ? Colors.grey[700] : const Color(0xff388e3c),
                ),
              );
            },
            tooltip: 'Save Page',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(context),
            const SizedBox(height: 24),
            _buildSection(context, "Understanding ASF", _understandingASFContent(context)),
            const SizedBox(height: 24),
            _buildSection(context, "Prevention Strategies", _preventionStrategiesContent(context)),
            const SizedBox(height: 24),
            _buildTipsSection(context), // Fixed reference
            const SizedBox(height: 24),
            _buildLearnMoreSection(context), // Fixed reference
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showQuickTipsDialog(context),
        backgroundColor: ArgieColors.secondary,
        child: const Icon(Icons.lightbulb_outline, color: Colors.white),
        tooltip: 'Quick Tips',
        elevation: 4,
      ),
    );
  }

  // Title Section
  Widget _buildTitle(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Row(
      children: [
        Expanded(
          child: Text(
            "Preventing African Swine Fever",
            style: GoogleFonts.poppins(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: isDarkMode ? Colors.white : const Color(0xff1b5e20),
              height: 1.2,
            ),
          ),
        ),
        const Icon(Icons.local_hospital, color: Color(0xff388e3c), size: 36),
      ],
    );
  }

  // Reusable Section Builder
  Widget _buildSection(BuildContext context, String title, Widget content) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: isDarkMode ? Colors.grey[800] : Colors.white,
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        collapsedBackgroundColor: isDarkMode ? Colors.grey[700] : const Color(0xffc8e6c9),
        backgroundColor: isDarkMode ? Colors.grey[800] : Colors.white,
        leading: Icon(
          title == "Understanding ASF" ? Icons.info_outline : Icons.shield,
          color: isDarkMode ? Colors.white70 : const Color(0xff2e7d32),
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: isDarkMode ? Colors.white : const Color(0xff1b5e20),
          ),
        ),
        children: [content],
      ),
    );
  }

  // Understanding ASF Content
  Widget _understandingASFContent(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "African Swine Fever (ASF) is a devastating viral disease affecting domestic and wild pigs. It has no vaccine or cure, making prevention vital for farmers. ASF spreads through direct contact, contaminated objects, or ticks.",
            style: GoogleFonts.poppins(fontSize: 16, color: isDarkMode ? Colors.white70 : Colors.black87, height: 1.5),
          ),
          const SizedBox(height: 12),
          _buildImageCard(context, "assets/images/preventingafricanswinefeverimages/asf_symptoms.jpg", "Pig showing bluish ears and fever"), // Fixed reference
          const SizedBox(height: 12),
          Text.rich(
            TextSpan(
              style: GoogleFonts.poppins(fontSize: 16, color: isDarkMode ? Colors.white70 : Colors.black87),
              children: [
                const TextSpan(text: "Key Symptoms:\n"),
                TextSpan(
                  text: "• High fever (>40°C)\n• Appetite loss\n• Bluish ears/skin\n• Sudden death\n",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: isDarkMode ? Colors.redAccent[100] : const Color(0xffd32f2f)),
                ),
                TextSpan(text: "\nImpact: ASF can wipe out entire herds, causing severe economic losses. It’s not harmful to humans but is a global threat to pig farming (Source: WOAH)."),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Prevention Strategies Content
  Widget _preventionStrategiesContent(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPreventionItem(context, "1. Biosecurity Measures", [ // Fixed reference
            "Limit farm visitors and use disinfectant footbaths (DAERA).",
            "Avoid swill feeding (kitchen scraps) as it’s a common ASF source (FAO).",
            "Control ticks and wild boar access."
          ], "assets/images/preventingafricanswinefeverimages/BiosecurityMeasures.jpg", "Disinfectant footbath in action"),
          const SizedBox(height: 16),
          _buildPreventionItem(context, "2. Isolation Protocols", [ // Fixed reference
            "Quarantine new pigs for 30+ days (USDA).",
            "Isolate sick pigs immediately and notify a vet."
          ], "assets/images/preventingafricanswinefeverimages/quarantineasf.jpg", "Quarantined pig area"),
          const SizedBox(height: 16),
          _buildPreventionItem(context, "3. Hygiene Practices", [ // Fixed reference
            "Disinfect tools, vehicles, and pens regularly (WOAH).",
            "Properly dispose of carcasses to avoid spread."
          ], "assets/images/preventingafricanswinefeverimages/HygienePractices.png", "Cleaning pig pens"),
          const SizedBox(height: 16),
          _buildPreventionItem(context, "4. Monitoring and Reporting", [ // Fixed reference
            "Check pigs daily for ASF signs.",
            "Report outbreaks to authorities fast to limit spread (DAERA)."
          ], "assets/images/preventingafricanswinefeverimages/monitoringASF.jpg", "Farmer checking pigs"),
        ],
      ),
    );
  }

  // Build Prevention Item
  Widget _buildPreventionItem(BuildContext context, String title, List<String> points, String imagePath, String caption) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: isDarkMode ? Colors.white : const Color(0xff1b5e20))),
        const SizedBox(height: 8),
        _buildImageCard(context, imagePath, caption), // Fixed reference
        const SizedBox(height: 8),
        ...points.map((point) => Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 4),
          child: Text("• $point", style: GoogleFonts.poppins(fontSize: 16, color: isDarkMode ? Colors.white70 : Colors.black87, fontWeight: FontWeight.w500)),
        )),
      ],
    );
  }

  // Build Image Card
  Widget _buildImageCard(BuildContext context, String imagePath, String caption) { // Fixed definition
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: isDarkMode ? Colors.black26 : Colors.black12, blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          children: [
            Image.asset(imagePath, height: 120, width: double.infinity, fit: BoxFit.cover),
            Container(
              padding: const EdgeInsets.all(8),
              color: isDarkMode ? Colors.grey[800] : Colors.white,
              child: Text(caption, style: GoogleFonts.poppins(fontSize: 12, color: isDarkMode ? Colors.grey[400] : Colors.black54)),
            ),
          ],
        ),
      ),
    );
  }

  // Build Tips Section
  Widget _buildTipsSection(BuildContext context) { // Fixed definition
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [isDarkMode ? Colors.grey[700]! : const Color(0xffc8e6c9), isDarkMode ? Colors.grey[600]! : const Color(0xffa5d6a7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Pro Tips for ASF Prevention",
            style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600, color: isDarkMode ? Colors.white : const Color(0xff1b5e20)),
          ),
          const SizedBox(height: 12),
          _buildTipItem(context, Icons.verified, "Train staff on ASF risks and biosecurity."),
          _buildTipItem(context, Icons.verified, "Use separate boots and clothing for pig areas."),
          _buildTipItem(context, Icons.verified, "Monitor wild boar activity near your farm."),
          _buildTipItem(context, Icons.verified, "Work with vets for early detection plans."),
        ],
      ),
    );
  }

  // Build Tip Item
  Widget _buildTipItem(BuildContext context, IconData icon, String text) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: isDarkMode ? Colors.white70 : const Color(0xff2e7d32), size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(text, style: GoogleFonts.poppins(fontSize: 16, color: isDarkMode ? Colors.white70 : Colors.black87)),
          ),
        ],
      ),
    );
  }

  // Build Learn More Section
  Widget _buildLearnMoreSection(BuildContext context) { // Fixed definition
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Learn More",
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600, color: isDarkMode ? Colors.white : const Color(0xff1b5e20)),
        ),
        const SizedBox(height: 12),
        _buildLink(context, "DAERA ASF Guide", "https://www.daera-ni.gov.uk/articles/african-swine-fever"),
        _buildLink(context, "USDA ASF Protection Tips", "https://www.aphis.usda.gov/sites/default/files/veterinarians-7-ways-to-protect-pigs-from-asf.pdf"),
        _buildLink(context, "FAO ASF Manual", "https://openknowledge.fao.org/server/api/core/bitstreams/773b174a-a962-4242-9dde-97cb1c86b9fb/content"),
        _buildLink(context, "WOAH ASF Info", "https://www.woah.org/en/disease/african-swine-fever/"),
      ],
    );
  }

  // Build Link
  Widget _buildLink(BuildContext context, String title, String url) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Icon(Icons.link, color: isDarkMode ? Colors.lightBlueAccent : const Color(0xff1976d2), size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.poppins(fontSize: 16, color: isDarkMode ? Colors.lightBlueAccent : const Color(0xff1976d2), decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Show Quick Tips Dialog
  void _showQuickTipsDialog(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: isDarkMode ? Colors.grey[800] : const Color(0xffe8f5e9),
        title: Row(
          children: [
            const Icon(Icons.lightbulb_outline, color: Color(0xff2e7d32)),
            const SizedBox(width: 8),
            Text("Quick ASF Tips", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: isDarkMode ? Colors.white : const Color(0xff1b5e20))),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("• Wash hands before and after handling pigs.", style: GoogleFonts.poppins(fontSize: 16, color: isDarkMode ? Colors.white70 : Colors.black87)),
            Text("• Keep farm records of pig movements.", style: GoogleFonts.poppins(fontSize: 16, color: isDarkMode ? Colors.white70 : Colors.black87)),
            Text("• Avoid contact with unknown pigs.", style: GoogleFonts.poppins(fontSize: 16, color: isDarkMode ? Colors.white70 : Colors.black87)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Got it!", style: GoogleFonts.poppins(fontSize: 16, color: isDarkMode ? Colors.white : const Color(0xff388e3c))),
          ),
        ],
      ),
    );
  }
}