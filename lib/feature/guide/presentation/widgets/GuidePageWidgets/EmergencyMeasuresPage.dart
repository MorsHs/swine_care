import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyMeasuresPage extends StatefulWidget {
  const EmergencyMeasuresPage({super.key});

  @override
  _EmergencyMeasuresPageState createState() => _EmergencyMeasuresPageState();
}

class _EmergencyMeasuresPageState extends State<EmergencyMeasuresPage> {
  bool _showImmediateActions = true;
  bool _showProtocols = false;

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9F5), // Softer background
      appBar: AppBar(
        backgroundColor: const Color(0xFFB0B422),
        elevation: 4,
        shadowColor: Colors.black26,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go('/guide'),
        ),
        title: Text(
          "Swine Emergency Guide",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.phone, color: Colors.white),
            onPressed: () => _launchURL("tel:+639123456789"), // Real phone number
            tooltip: "Call Vet",
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [const Color(0xFFB0B422), const Color(0xFFD9D367)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Immediate Actions Section
            _buildSectionHeader(
              "Immediate Actions",
              _showImmediateActions,
                  () => setState(() => _showImmediateActions = !_showImmediateActions),
            ),
            AnimatedCrossFade(
              firstChild: _buildContentCard(
                "When a disease outbreak strikes, act fast to protect your herd:\n\n"
                    "1. Isolate Affected Pigs:\n"
                    "• Move sick pigs calmly using low-stress handling (e.g., boards, not sticks).\n"
                    "• Set up a quarantine pen at least 200 feet from healthy pigs.\n\n"
                    "2. Contact Authorities:\n"
                    "• Call your local vet or animal health office immediately.\n"
                    "• Report symptoms like high fever or sudden deaths.\n\n"
                    "3. Lock Down the Farm:\n"
                    "• Restrict all visitors and vehicles.\n"
                    "• Set up footbaths with disinfectant at entry points.",
                imagePath: 'assets/images/emergencymeasuresimages/quarantinesetup.jpg',
                imageCaption: "Quarantine pen setup for sick pigs",
              ),
              secondChild: const SizedBox.shrink(),
              crossFadeState: _showImmediateActions
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 300),
            ),
            const SizedBox(height: 20),

            // Emergency Protocols Section
            _buildSectionHeader(
              "Emergency Protocols",
              _showProtocols,
                  () => setState(() => _showProtocols = !_showProtocols),
            ),
            AnimatedCrossFade(
              firstChild: _buildContentCard(
                "1. Disinfection Procedures:\n"
                    "• Wash pens with hot water, then apply disinfectants (e.g., Virkon-S or bleach).\n"
                    "• Disinfect boots, tools, and trailers after every use.\n\n"
                    "2. Monitor Symptoms:\n"
                    "• Look for fever (>104°F), lameness, or bluish skin daily.\n"
                    "• Use a logbook or app to track health changes.\n\n"
                    "3. Cull Infected Animals:\n"
                    "• If ASF is confirmed, cull humanely with vet oversight.\n"
                    "• Bury or incinerate carcasses per local rules.\n\n"
                    "Warning: ASF has no treatment—focus on containment!",
                imagePath: 'assets/images/emergencymeasuresimages/disinfection.jpg',
                imageCaption: "Disinfecting a pig pen",
              ),
              secondChild: const SizedBox.shrink(),
              crossFadeState: _showProtocols
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 300),
            ),
            const SizedBox(height: 20),

            // Tips Section
            _buildTipsSection(),
            const SizedBox(height: 20),

            // Links Section
            _buildLinksSection(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _launchURL("tel:+639123456789"),
        backgroundColor: const Color(0xFFFFA726),
        child: const Icon(Icons.call, color: Colors.white),
        tooltip: "Emergency Call",
      ),
    );
  }

  Widget _buildSectionHeader(String title, bool isExpanded, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFB0B422), Color(0xFFD9D367)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            Icon(
              isExpanded ? Icons.expand_less : Icons.expand_more,
              color: Colors.white,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentCard(String text, {String? imagePath, String? imageCaption}) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                style: GoogleFonts.poppins(fontSize: 16, color: Colors.black87, height: 1.6),
                children: text.split('\n').map((line) {
                  if (line.startsWith('•') || line.startsWith('Warning')) {
                    return TextSpan(
                      text: '$line\n',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: line.startsWith('Warning') ? Colors.redAccent : Colors.black87,
                      ),
                    );
                  } else {
                    return TextSpan(text: '$line\n');
                  }
                }).toList(),
              ),
            ),
            if (imagePath != null) ...[
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  imagePath,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                imageCaption ?? '',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTipsSection() {
    return Card(
      elevation: 3,
      color: Colors.grey[50],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Pro Tips for Emergency Situations",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            _buildTipItem(Icons.check_circle_outline, "Use herd behavior—pigs follow each other—to move them quickly."),
            _buildTipItem(Icons.check_circle_outline, "Store a 3-day supply of feed and water for emergencies."),
            _buildTipItem(Icons.check_circle_outline, "Post biosecurity signs at all entrances."),
            _buildTipItem(Icons.check_circle_outline, "Practice a mock outbreak drill yearly."),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/images/emergencymeasuresimages/biosecuritycheckpoint.jpg',
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Biosecurity checkpoint at farm entrance",
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFFB0B422), size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLinksSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Learn More",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            _buildLinkItem(
              "ASF Emergency Guidelines (DA Philippines)",
              "https://www.da.gov.ph/african-swine-fever-asf/",
            ),
            _buildLinkItem(
              "Swine Disease Management",
              "https://www.agriculture.com.ph/2022/08/10/a-guide-to-swine-raising-in-the-philippines/",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLinkItem(String text, String url) {
    return GestureDetector(
      onTap: () => _launchURL(url),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            const Icon(Icons.launch, color: Color(0xFFB0B422), size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: const Color(0xFFB0B422),
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}