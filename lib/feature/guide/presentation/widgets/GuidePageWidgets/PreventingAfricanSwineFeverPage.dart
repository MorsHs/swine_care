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
      backgroundColor: isDarkMode ? Colors.grey[850] : const Color(0xFFF5F7F2),
      appBar: AppBar(
        backgroundColor: ArgieColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go('/guide'),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark_outline, color: isDarkMode ? Colors.white : const Color(0xFFF5F7F2)),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Saved to Favorites!",
                    style: TextStyle(color: isDarkMode ? Colors.white : Colors.black87),
                  ),
                  backgroundColor: isDarkMode ? Colors.grey[700] : ArgieColors.secondary,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  margin: const EdgeInsets.all(16),
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
            AnimatedOpacity(
              opacity: 1.0,
              duration: const Duration(milliseconds: 500),
              child: _buildTitle(context),
            ),
            const SizedBox(height: 24),
            AnimatedOpacity(
              opacity: 1.0,
              duration: const Duration(milliseconds: 600),
              child: _buildSection(context, "Understanding ASF", _understandingASFContent(context)),
            ),
            const SizedBox(height: 24),
            AnimatedOpacity(
              opacity: 1.0,
              duration: const Duration(milliseconds: 700),
              child: _buildSection(context, "Prevention Strategies", _preventionStrategiesContent(context)),
            ),
            const SizedBox(height: 24),
            AnimatedOpacity(
              opacity: 1.0,
              duration: const Duration(milliseconds: 800),
              child: _buildSection(context, "Economic Impact", _economicImpactContent(context)),
            ),
            const SizedBox(height: 24),
            AnimatedOpacity(
              opacity: 1.0,
              duration: const Duration(milliseconds: 900),
              child: _buildSection(context, "Community Collaboration", _communityCollaborationContent(context)),
            ),
            const SizedBox(height: 24),
            AnimatedOpacity(
              opacity: 1.0,
              duration: const Duration(milliseconds: 1000),
              child: _buildTipsSection(context),
            ),
            const SizedBox(height: 24),
            AnimatedOpacity(
              opacity: 1.0,
              duration: const Duration(milliseconds: 1100),
              child: _buildLearnMoreSection(context),
            ),
          ],
        ),
      ),
      floatingActionButton: ScaleTransition(
        scale: Tween<double>(begin: 0.9, end: 1.0).animate(
          CurvedAnimation(parent: AnimationController(vsync: Navigator.of(context), duration: const Duration(milliseconds: 500))..forward(), curve: Curves.easeInOut),
        ),
        child: FloatingActionButton(
          onPressed: () => _showQuickTipsDialog(context),
          backgroundColor: ArgieColors.secondary,
          child: const Icon(Icons.lightbulb_outline, color: Colors.white),
          tooltip: 'Quick Tips',
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
    );
  }

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
              color: isDarkMode ? Colors.white : const Color(0xFF1B5E20),
              height: 1.2,
            ),
          ),
        ),
        Icon(Icons.local_hospital, color: isDarkMode ? Colors.greenAccent[100] : const Color(0xFF388E3C), size: 36),
      ],
    );
  }

  Widget _buildSection(BuildContext context, String title, Widget content) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: isDarkMode ? Colors.grey[800] : Colors.white,
      shadowColor: isDarkMode ? Colors.black26 : Colors.grey[300],
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        collapsedBackgroundColor: isDarkMode ? Colors.grey[700] : const Color(0xFFC8E6C9),
        backgroundColor: isDarkMode ? Colors.grey[800] : Colors.white,
        leading: Icon(
          title == "Understanding ASF" ? Icons.info_outline :
          title == "Prevention Strategies" ? Icons.shield :
          title == "Economic Impact" ? Icons.money :
          Icons.people,
          color: isDarkMode ? Colors.white70 : const Color(0xFF2E7D32),
          size: 28,
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: isDarkMode ? Colors.white : const Color(0xFF1B5E20),
          ),
        ),
        children: [content],
        collapsedIconColor: isDarkMode ? Colors.white70 : const Color(0xFF2E7D32),
        iconColor: isDarkMode ? Colors.white70 : const Color(0xFF2E7D32),
      ),
    );
  }

  Widget _understandingASFContent(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "African Swine Fever (ASF) is a highly contagious viral disease that devastates pig populations worldwide. Caused by a double-stranded DNA virus, it has no vaccine or cure, making prevention the only defense. ASF spreads through direct pig-to-pig contact, contaminated feed, or vectors like ticks and wild boars.",
            style: GoogleFonts.poppins(fontSize: 16, color: isDarkMode ? Colors.white70 : Colors.black87, height: 1.5),
          ),
          const SizedBox(height: 16),
          _buildImageCard(context, "assets/images/preventingafricanswinefeverimages/asf_symptoms.jpg", "Pig showing ASF symptoms"),
          const SizedBox(height: 16),
          Text.rich(
            TextSpan(
              style: GoogleFonts.poppins(fontSize: 16, color: isDarkMode ? Colors.white70 : Colors.black87),
              children: [
                const TextSpan(text: "Key Symptoms:\n"),
                TextSpan(
                  text: "• High fever (>40°C)\n• Loss of appetite\n• Bluish ears and skin\n• Sudden death within days\n",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: isDarkMode ? Colors.redAccent[100] : const Color(0xFFD32F2F)),
                ),
                TextSpan(text: "\nImpact: ASF can wipe out entire herds, with mortality rates up to 100% in acute cases. It poses no risk to human health but threatens global pork industries (Source: WOAH)."),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _preventionStrategiesContent(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPreventionItem(context, "1. Biosecurity Measures", [
            "Restrict farm visitors and install disinfectant footbaths (DAERA).",
            "Prohibit swill feeding to eliminate ASF transmission via kitchen waste (FAO).",
            "Control tick populations and block wild boar entry with fencing."
          ], "assets/images/preventingafricanswinefeverimages/BiosecurityMeasures.jpg", "Disinfectant footbath setup"),
          const SizedBox(height: 16),
          _buildPreventionItem(context, "2. Isolation Protocols", [
            "Quarantine new or returning pigs for at least 30-40 days (USDA).",
            "Isolate sick pigs immediately and contact a veterinarian promptly."
          ], "assets/images/preventingafricanswinefeverimages/quarantineasf.jpg", "Isolated quarantine area"),
          const SizedBox(height: 16),
          _buildPreventionItem(context, "3. Hygiene Practices", [
            "Disinfect tools, vehicles, and pens weekly using approved solutions (WOAH).",
            "Dispose of carcasses safely to prevent environmental contamination."
          ], "assets/images/preventingafricanswinefeverimages/HygienePractices.png", " sanitized pig pen"),
          const SizedBox(height: 16),
          _buildPreventionItem(context, "4. Monitoring and Reporting", [
            "Conduct daily health checks for ASF symptoms.",
            "Report suspected cases to local authorities within 24 hours (DAERA)."
          ], "assets/images/preventingafricanswinefeverimages/monitoringASF.jpg", "Veterinary health check"),
        ],
      ),
    );
  }

  Widget _economicImpactContent(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "ASF’s economic toll on pig farming is immense, affecting farmers, markets, and entire economies. Outbreaks lead to herd culling, trade bans, and loss of livelihoods.",
            style: GoogleFonts.poppins(fontSize: 16, color: isDarkMode ? Colors.white70 : Colors.black87, height: 1.5),
          ),
          const SizedBox(height: 16),
          _buildImageCard(context, "assets/images/preventingafricanswinefeverimages/economicimpact.jpg", "Destroyed pig farm"),
          const SizedBox(height: 16),
          Text.rich(
            TextSpan(
              style: GoogleFonts.poppins(fontSize: 16, color: isDarkMode ? Colors.white70 : Colors.black87),
              children: [
                const TextSpan(text: "Key Impacts:\n"),
                TextSpan(
                  text: "• Loss of 50-100% of herds in severe outbreaks\n• Export bans costing billions annually\n• Increased feed and labor costs\n",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: isDarkMode ? Colors.orangeAccent[100] : const Color(0xFFF57C00)),
                ),
                TextSpan(text: "\nExample: The 2019 ASF outbreak in Asia led to a P100 billion economic loss (FAO)."),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _communityCollaborationContent(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Preventing ASF requires collective effort beyond individual farms. Community collaboration strengthens regional biosecurity and response.",
            style: GoogleFonts.poppins(fontSize: 16, color: isDarkMode ? Colors.white70 : Colors.black87, height: 1.5),
          ),
          const SizedBox(height: 16),
          _buildImageCard(context, "assets/images/preventingafricanswinefeverimages/communityeffort.jpg", "Farmers meeting"),
          const SizedBox(height: 16),
          Text.rich(
            TextSpan(
              style: GoogleFonts.poppins(fontSize: 16, color: isDarkMode ? Colors.white70 : Colors.black87),
              children: [
                const TextSpan(text: "Key Actions:\n"),
                TextSpan(
                  text: "• Share biosecurity protocols with neighbors\n• Report sightings of sick wild boars\n• Participate in local training programs\n",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: isDarkMode ? Colors.tealAccent[100] : const Color(0xFF00695C)),
                ),
                TextSpan(text: "\nBenefit: Unified efforts in Europe reduced ASF spread by 30% (WOAH)."),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreventionItem(BuildContext context, String title, List<String> points, String imagePath, String caption) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: isDarkMode ? Colors.white : const Color(0xFF1B5E20))),
        const SizedBox(height: 8),
        _buildImageCard(context, imagePath, caption),
        const SizedBox(height: 8),
        ...points.map((point) => Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 4),
          child: Text("• $point", style: GoogleFonts.poppins(fontSize: 16, color: isDarkMode ? Colors.white70 : Colors.black87, fontWeight: FontWeight.w500)),
        )),
      ],
    );
  }

  Widget _buildImageCard(BuildContext context, String imagePath, String caption) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: isDarkMode ? Colors.black38 : Colors.grey[300]!, blurRadius: 8, offset: const Offset(0, 4))],
        gradient: LinearGradient(
          colors: isDarkMode ? [Colors.grey[800]!, Colors.grey[900]!] : [Colors.white, const Color(0xFFE8F5E9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          children: [
            Image.asset(imagePath, height: 120, width: double.infinity, fit: BoxFit.cover),
            Container(
              padding: const EdgeInsets.all(8),
              color: isDarkMode ? Colors.grey[800] : Colors.white,
              child: Text(caption, style: GoogleFonts.poppins(fontSize: 12, color: isDarkMode ? Colors.grey[400] : Colors.black54, fontWeight: FontWeight.w500)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipsSection(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [isDarkMode ? Colors.grey[700]! : const Color(0xFFC8E6C9), isDarkMode ? Colors.grey[600]! : const Color(0xFFA5D6A7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: isDarkMode ? Colors.black26 : Colors.grey[300]!, blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Pro Tips for ASF Prevention",
            style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600, color: isDarkMode ? Colors.white : const Color(0xFF1B5E20)),
          ),
          const SizedBox(height: 12),
          _buildTipItem(context, Icons.verified, "Train staff on ASF risks and biosecurity protocols."),
          _buildTipItem(context, Icons.verified, "Use dedicated boots and clothing for pig areas."),
          _buildTipItem(context, Icons.verified, "Monitor wild boar activity and report sightings."),
          _buildTipItem(context, Icons.verified, "Collaborate with vets for early detection plans."),
          _buildTipItem(context, Icons.verified, "Maintain a clean water supply to avoid contamination."),
        ],
      ),
    );
  }

  Widget _buildTipItem(BuildContext context, IconData icon, String text) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: isDarkMode ? Colors.white70 : const Color(0xFF2E7D32), size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(text, style: GoogleFonts.poppins(fontSize: 16, color: isDarkMode ? Colors.white70 : Colors.black87)),
          ),
        ],
      ),
    );
  }

  Widget _buildLearnMoreSection(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: isDarkMode ? Colors.grey[800] : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Learn More",
              style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600, color: isDarkMode ? Colors.white : const Color(0xFF1B5E20)),
            ),
            const SizedBox(height: 12),
            _buildLink(context, "DAERA ASF Guide", "https://www.daera-ni.gov.uk/articles/african-swine-fever"),
            _buildLink(context, "USDA ASF Protection Tips", "https://www.aphis.usda.gov/sites/default/files/veterinarians-7-ways-to-protect-pigs-from-asf.pdf"),
            _buildLink(context, "FAO ASF Manual", "https://openknowledge.fao.org/server/api/core/bitstreams/773b174a-a962-4242-9dde-97cb1c86b9fb/content"),
            _buildLink(context, "WOAH ASF Info", "https://www.woah.org/en/disease/african-swine-fever/"),
          ],
        ),
      ),
    );
  }

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
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Icon(Icons.link, color: isDarkMode ? Colors.lightBlueAccent : const Color(0xFF1976D2), size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: isDarkMode ? Colors.lightBlueAccent : const Color(0xFF1976D2),
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showQuickTipsDialog(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: isDarkMode ? Colors.grey[800] : const Color(0xFFE8F5E9),
        title: Row(
          children: [
            const Icon(Icons.lightbulb_outline, color: Color(0xFF2E7D32)),
            const SizedBox(width: 8),
            Text("Quick ASF Tips", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: isDarkMode ? Colors.white : const Color(0xFF1B5E20))),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("• Wash hands thoroughly before and after handling pigs.", style: GoogleFonts.poppins(fontSize: 16, color: isDarkMode ? Colors.white70 : Colors.black87)),
            Text("• Keep detailed records of pig movements and health.", style: GoogleFonts.poppins(fontSize: 16, color: isDarkMode ? Colors.white70 : Colors.black87)),
            Text("• Avoid contact with unknown or stray pigs.", style: GoogleFonts.poppins(fontSize: 16, color: isDarkMode ? Colors.white70 : Colors.black87)),
            Text("• Install motion sensors to detect wild boar intrusions.", style: GoogleFonts.poppins(fontSize: 16, color: isDarkMode ? Colors.white70 : Colors.black87)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Got it!", style: GoogleFonts.poppins(fontSize: 16, color: isDarkMode ? Colors.white : const Color(0xFF388E3C))),
          ),
        ],
      ),
    );
  }
}