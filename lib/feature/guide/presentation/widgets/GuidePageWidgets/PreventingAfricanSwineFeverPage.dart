import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class PreventingAfricanSwineFeverPage extends StatefulWidget {
  const PreventingAfricanSwineFeverPage({super.key});

  @override
  State<PreventingAfricanSwineFeverPage> createState() => _PreventingAfricanSwineFeverPageState();
}

class _PreventingAfricanSwineFeverPageState extends State<PreventingAfricanSwineFeverPage> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final ScrollController _scrollController;
  bool _showFab = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..forward();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
      if (_showFab) {
        setState(() {
          _showFab = false;
          _animationController.reverse();
        });
      }
    } else {
      if (!_showFab) {
        setState(() {
          _showFab = true;
          _animationController.forward();
        });
      }
    }
  }

  void _shareContent() {
    Share.share(
      'Learn how to protect your pigs from African Swine Fever (ASF)! Important biosecurity measures include:\n\n'
          '1) Strict farm access control\n'
          '2) No swill feeding\n'
          '3) Quarantine new animals\n'
          '4) Regular disinfection\n\n'
          'Check this guide from SwineGuide App.',
      subject: 'ASF Prevention Tips for Pig Farmers',
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Could not open $url',
              style: GoogleFonts.poppins(),
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF1E1E1E) : const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xff47b97f),
        elevation: 2,
        title: Text(
          'Preventing ASF',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_circle_left, color: Colors.white),
          onPressed: () => context.go('/guide'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.share, color: Colors.white),
            onPressed: _shareContent,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
              decoration: BoxDecoration(
                color: const Color(0xff47b97f),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'African Swine Fever',
                    style: GoogleFonts.poppins(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "Essential guide for Filipino pig farmers",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildAlertBanner(context),
                  const SizedBox(height: 20),
                  AnimatedOpacity(
                    opacity: 1.0,
                    duration: const Duration(milliseconds: 600),
                    child: _buildSection(context, "Understanding ASF",
                        _understandingASFContent(context)),
                  ),
                  const SizedBox(height: 20),
                  AnimatedOpacity(
                    opacity: 1.0,
                    duration: const Duration(milliseconds: 700),
                    child: _buildSection(context, "Prevention Strategies",
                        _preventionStrategiesContent(context)),
                  ),
                  const SizedBox(height: 20),
                  AnimatedOpacity(
                    opacity: 1.0,
                    duration: const Duration(milliseconds: 750),
                    child: _buildSection(context, "Early Detection",
                        _earlyDetectionContent(context)),
                  ),
                  const SizedBox(height: 20),
                  AnimatedOpacity(
                    opacity: 1.0,
                    duration: const Duration(milliseconds: 800),
                    child: _buildSection(
                        context, "Economic Impact", _economicImpactContent(context)),
                  ),
                  const SizedBox(height: 20),
                  AnimatedOpacity(
                    opacity: 1.0,
                    duration: const Duration(milliseconds: 900),
                    child: _buildSection(context, "Community Collaboration",
                        _communityCollaborationContent(context)),
                  ),
                  const SizedBox(height: 20),
                  AnimatedOpacity(
                    opacity: 1.0,
                    duration: const Duration(milliseconds: 950),
                    child: _buildSection(context, "Emergency Response Plan",
                        _emergencyResponseContent(context)),
                  ),
                  const SizedBox(height: 20),
                  AnimatedOpacity(
                    opacity: 1.0,
                    duration: const Duration(milliseconds: 1000),
                    child: _buildTipsSection(context),
                  ),
                  const SizedBox(height: 20),
                  AnimatedOpacity(
                    opacity: 1.0,
                    duration: const Duration(milliseconds: 1100),
                    child: _buildLearnMoreSection(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: ScaleTransition(
        scale: CurvedAnimation(
          parent: _animationController,
          curve: Curves.elasticOut,
        ),
        child: FloatingActionButton.extended(
          onPressed: () => _showQuickTipsDialog(context),
          backgroundColor: const Color(0xff47b97f),
          icon: const Icon(Icons.lightbulb_outline, color: Colors.white),
          label: Text(
            'Quick Tips',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  Widget _buildAlertBanner(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.red[900]!.withValues(alpha: 0.3) : Colors.red[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDarkMode ? Colors.red[700]! : Colors.red[200]!,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.red[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.warning_amber_rounded,
              color: Colors.red[700],
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'High Alert: ASF Prevention',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? Colors.red[100] : Colors.red[900],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Implement strict biosecurity measures. Report any suspicious cases immediately.',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: isDarkMode ? Colors.white70 : Colors.red[900],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, Widget content) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Hero(
      tag: 'section_$title',
      child: Material(
        color: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: isDarkMode ? const Color(0xFF2A2A2A) : Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              Navigator.of(context).push(
                FadePageRoute(
                  builder: (context) => DetailPage(
                    title: title,
                    content: content,
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  _getSectionIcon(context, title),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: isDarkMode ? Colors.white : const Color(0xFF2C6E49),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getSectionIcon(BuildContext context, String title) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color iconColor = isDarkMode ? const Color(0xFF47B97F) : const Color(0xFF2C6E49);
    final Color bgColor = isDarkMode ? Colors.grey[800]! : const Color(0xFFEAF7EF);

    IconData icon;
    if (title == "Understanding ASF") {
      icon = Icons.info_outline;
    } else if (title == "Prevention Strategies") {
      icon = Icons.shield_outlined;
    } else if (title == "Early Detection") {
      icon = Icons.search;
    } else if (title == "Economic Impact") {
      icon = Icons.attach_money;
    } else if (title == "Community Collaboration") {
      icon = Icons.people_outline;
    } else if (title == "Emergency Response Plan") {
      icon = Icons.emergency;
    } else {
      icon = Icons.help_outline;
    }

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: iconColor, size: 24),
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
            "African Swine Fever (ASF) is a highly contagious viral disease affecting domestic and wild pigs. It's caused by a large DNA virus of the Asfarviridae family. With no vaccine or treatment available, prevention is crucial for pig farmers.",
            style: GoogleFonts.poppins(
                fontSize: 16,
                color: isDarkMode ? Colors.white70 : Colors.black87,
                height: 1.5),
          ),
          const SizedBox(height: 16),
          _buildImageCard(
              context,
              "assets/images/preventingafricanswinefeverimages/asf_symptoms.jpg",
              "Pig showing ASF symptoms"),
          const SizedBox(height: 16),
          Text.rich(
            TextSpan(
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: isDarkMode ? Colors.white70 : Colors.black87),
              children: [
                TextSpan(
                  text: "Key Symptoms:\n",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text:
                  "• High fever (40.5-42°C)\n• Loss of appetite and weakness\n• Red/bluish skin (ears, abdomen, legs)\n• Vomiting and diarrhea (sometimes bloody)\n• Difficulty breathing\n• Sudden death within 7-10 days\n",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: isDarkMode
                          ? Colors.redAccent[100]
                          : const Color(0xFFD32F2F)),
                ),
                TextSpan(
                    text:
                    "\nTransmission Methods:\n• Direct contact with infected pigs\n• Indirect contact through contaminated equipment\n• Consumption of infected pork products (swill feeding)\n• Soft ticks (in some regions)\n• Contaminated vehicles or clothing\n\nASF is extremely deadly with up to 100% mortality in affected herds. While it doesn't affect humans, it devastates pig farming livelihoods."),
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
          Text(
            "Effective biosecurity is your farm's best defense against ASF. These measures significantly reduce the risk of disease introduction and spread.",
            style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isDarkMode ? Colors.white70 : Colors.black87,
                height: 1.5),
          ),
          const SizedBox(height: 16),
          _buildPreventionItem(
              context,
              "1. Farm Access Control",
              [
                "Install perimeter fencing around your entire farm property",
                "Create a single controlled entry point with disinfection station",
                "Restrict visitors - only essential personnel with clean clothing",
                "Implement strict vehicle disinfection protocols for all vehicles"
              ],
              "assets/images/preventingafricanswinefeverimages/BiosecurityMeasures.jpg",
              "Disinfectant footbath at farm entrance"),
          const SizedBox(height: 16),
          _buildPreventionItem(
              context,
              "2. Feeding Practices",
              [
                "Never feed food scraps or leftovers (swill) to pigs",
                "Use only commercial feed from reputable suppliers",
                "Store feed in sealed containers to prevent contamination",
                "Implement dedicated feeding equipment for each pen"
              ],
              "assets/images/preventingafricanswinefeverimages/FEEDINGPRACTICE.jpg",
              "Safe commercial feed storage"),
          const SizedBox(height: 16),
          _buildPreventionItem(
              context,
              "3. Animal Isolation",
              [
                "Quarantine new or returning pigs for at least 30-40 days",
                "Use separate tools, clothing and staff for quarantine areas",
                "Monitor quarantined animals daily for any signs of illness",
                "Test animals before introducing them to the main herd"
              ],
              "assets/images/preventingafricanswinefeverimages/quarantineasf.jpg",
              "Isolated quarantine area for new pigs"),
          const SizedBox(height: 16),
          _buildPreventionItem(
              context,
              "4. Sanitation & Disinfection",
              [
                "Clean and disinfect pens, equipment and vehicles regularly",
                "Use ASF-effective disinfectants (glutaraldehyde, formaldehyde)",
                "Establish clear dirty/clean zones with proper transitions",
                "Provide clean boots and clothing for farm workers"
              ],
              "assets/images/preventingafricanswinefeverimages/HygienePractices.png",
              "Regular pen disinfection procedures"),
          const SizedBox(height: 16),
          _buildPreventionItem(
              context,
              "5. Wild Pig/Boar Control",
              [
                "Reinforce fencing to prevent wild pig contact with domestic pigs",
                "Monitor and report wild boar sightings in your area",
                "Remove attractants (food waste, carcasses) from farm perimeter",
                "Consider electric fencing in high-risk areas"
              ],
              "assets/images/preventingafricanswinefeverimages/WILDPIG.jpg",
              "Wild boar exclusion fencing"),
        ],
      ),
    );
  }

  Widget _earlyDetectionContent(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Early detection is critical for limiting ASF spread. Learn to identify signs quickly and implement immediate containment.",
            style: GoogleFonts.poppins(
                fontSize: 16,
                color: isDarkMode ? Colors.white70 : Colors.black87,
                height: 1.5),
          ),
          const SizedBox(height: 16),
          _buildImageCard(
              context,
              "assets/images/preventingafricanswinefeverimages/monitoringASF.jpg",
              "Daily health monitoring of pigs"),
          const SizedBox(height: 16),
          Text(
            "Daily Monitoring Protocol:",
            style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black87),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.grey[800] : Colors.grey[100],
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMonitoringStep(context, "1", "Check each pig's appetite and behavior"),
                _buildMonitoringStep(context, "2", "Monitor for fever (normal pig temperature: 38.0-39.3°C)"),
                _buildMonitoringStep(context, "3", "Examine skin for redness, especially ears and abdomen"),
                _buildMonitoringStep(context, "4", "Look for gastrointestinal issues (vomiting/diarrhea)"),
                _buildMonitoringStep(context, "5", "Count and record any unexplained deaths"),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Immediate Actions if ASF is Suspected:",
            style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black87),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.redAccent.withValues(alpha: 0.2): Colors.red[50],
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDarkMode ? Colors.red[900]! : Colors.red[200]!,
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildActionStep(context, Icons.call, "Contact your local veterinarian immediately"),
                _buildActionStep(context, Icons.block, "Stop all movement of pigs onto or off the farm"),
                _buildActionStep(context, Icons.security, "Isolate sick animals from the rest of the herd"),
                _buildActionStep(context, Icons.cleaning_services, "Increase disinfection of all equipment and areas"),
                _buildActionStep(context, Icons.report, "Report to authorities at DA-BAI: (02) 8920-0129"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonitoringStep(BuildContext context, String number, String text) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.red[800] : Colors.red[600],
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: isDarkMode ? Colors.white70 : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionStep(BuildContext context, IconData icon, String text) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 24,
            color: isDarkMode ? Colors.red[300] : Colors.red[700],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
          ),
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
            "ASF has devastating economic consequences for pig farms of all sizes. Understanding these impacts highlights why prevention is essential.",
            style: GoogleFonts.poppins(
                fontSize: 16,
                color: isDarkMode ? Colors.white70 : Colors.black87,
                height: 1.5),
          ),
          const SizedBox(height: 16),
          _buildImageCard(
              context,
              "assets/images/preventingafricanswinefeverimages/economicimpact.jpg",
              "Economic impact on pig farms"),
          const SizedBox(height: 16),
          Text.rich(
            TextSpan(
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: isDarkMode ? Colors.white70 : Colors.black87),
              children: [
                TextSpan(
                  text: "Financial Impact on Farmers:\n",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text:
                  "• Complete loss of pig inventory (mortality rates of 50-100%)\n• Costs of mandatory culling and disposal\n• Lost breeding stock and genetic improvements\n• Income loss during lengthy farm disinfection period\n• Increased biosecurity investment costs\n",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: isDarkMode
                          ? Colors.orangeAccent[100]
                          : const Color(0xFFF57C00)),
                ),
                const TextSpan(
                    text:
                    "\nNational Economic Impact:\n• The 2019-2021 ASF outbreaks cost the Philippine hog industry over ₱100 billion\n• Reduced pork production and higher consumer prices\n• Job losses in farm and processing sectors\n• Export restrictions affecting trade balance\n\nRecovery Timeframe: Affected farms typically require 6-12 months to fully repopulate and return to production after an ASF outbreak, creating long-term livelihood impacts."),
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
            "Preventing ASF requires collective action. Farmers working together can establish stronger biosecurity across an entire region.",
            style: GoogleFonts.poppins(
                fontSize: 16,
                color: isDarkMode ? Colors.white70 : Colors.black87,
                height: 1.5),
          ),
          const SizedBox(height: 16),
          _buildImageCard(
              context,
              "assets/images/preventingafricanswinefeverimages/communityeffort.jpg",
              "Farmers meeting"),
          const SizedBox(height: 16),
          Text.rich(
            TextSpan(
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: isDarkMode ? Colors.white70 : Colors.black87),
              children: [
                const TextSpan(text: "Key Actions:\n"),
                TextSpan(
                  text:
                  "• Share biosecurity protocols with neighbors\n• Report sightings of sick wild boars\n• Participate in local training programs\n",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: isDarkMode
                          ? Colors.tealAccent[100]
                          : const Color(0xFF00695C)),
                ),
                TextSpan(
                    text:
                    "\nBenefit: Unified efforts in Europe reduced ASF spread by 30% (WOAH)."),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreventionItem(BuildContext context, String title,
      List<String> points, String imagePath, String caption) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: isDarkMode ? Colors.white : const Color(0xFF1B5E20))),
        const SizedBox(height: 8),
        _buildImageCard(context, imagePath, caption),
        const SizedBox(height: 8),
        ...points.map((point) => Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 4),
          child: Text("• $point",
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: isDarkMode ? Colors.white70 : Colors.black87,
                  fontWeight: FontWeight.w500)),
        )),
      ],
    );
  }

  Widget _buildImageCard(
      BuildContext context, String imagePath, String caption) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.black38 : Colors.grey.withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            Image.asset(
              imagePath,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 180,
                  width: double.infinity,
                  color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    size: 50,
                    color: isDarkMode ? Colors.grey[600] : Colors.grey[400],
                  ),
                );
              },
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xFF2A2A2A) : Colors.white,
                border: Border(
                  top: BorderSide(
                    color: isDarkMode ? Colors.grey[800]! : Colors.grey[200]!,
                    width: 1,
                  ),
                ),
              ),
              child: Text(
                caption,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipsSection(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.black12 : Colors.black.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 8),
            spreadRadius: 1,
          ),
        ],
        gradient: LinearGradient(
          colors: isDarkMode
              ? [const Color(0xFF2A2A2A), const Color(0xFF303030)]
              : [const Color(0xFFE8F5E9), const Color(0xFFC8E6C9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.transparent,
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.grey[800] : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.tips_and_updates_outlined,
                      color: const Color(0xFF47B97F),
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    "Pro Tips for ASF Prevention",
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode ? Colors.white : const Color(0xFF2C6E49),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildTipItem(context, Icons.verified_outlined, "Train staff on ASF risks and biosecurity protocols."),
              _buildTipItem(context, Icons.verified_outlined, "Use dedicated boots and clothing for pig areas."),
              _buildTipItem(context, Icons.verified_outlined, "Monitor wild boar activity and report sightings."),
              _buildTipItem(context, Icons.verified_outlined, "Collaborate with vets for early detection plans."),
              _buildTipItem(context, Icons.verified_outlined, "Maintain a clean water supply to avoid contamination."),

              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? Colors.grey[800]!.withValues(alpha: 0.5)
                      : Colors.white.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      color: isDarkMode ? Colors.yellowAccent : Colors.amber,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "Pig farmers who follow these best practices have reduced ASF risk by up to 70%",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: isDarkMode ? Colors.white70 : Colors.black87,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTipItem(BuildContext context, IconData icon, String text) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: const Color(0xFF47B97F),
            size: 22,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: isDarkMode ? Colors.white70 : Colors.black87,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLearnMoreSection(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.black12 : Colors.black.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 8),
            spreadRadius: 1,
          ),
        ],
      ),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: isDarkMode ? const Color(0xFF2A2A2A) : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.grey[800] : const Color(0xFFEAF7EF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.menu_book_outlined,
                      color: const Color(0xFF47B97F),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    "Learn More",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode ? Colors.white : const Color(0xFF2C6E49),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                "Access these valuable resources to deepen your knowledge on ASF prevention:",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: isDarkMode ? Colors.white70 : Colors.black87,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 16),
              _buildLink(context, "DAERA ASF Guide",
                  "https://www.daera-ni.gov.uk/articles/african-swine-fever"),
              _buildLink(context, "USDA ASF Protection Tips",
                  "https://www.aphis.usda.gov/sites/default/files/veterinarians-7-ways-to-protect-pigs-from-asf.pdf"),
              _buildLink(context, "FAO ASF Manual",
                  "https://openknowledge.fao.org/server/api/core/bitstreams/773b174a-a962-4242-9dde-97cb1c86b9fb/content"),
              _buildLink(context, "WOAH ASF Info",
                  "https://www.woah.org/en/disease/african-swine-fever/"),
              _buildLink(context, "Philippine Resources",
                  "https://www.da.gov.ph/wp-content/uploads/2019/09/ASFPreventionMeasures.pdf"),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.grey[800]!.withValues(alpha: 0.5) : const Color(0xFFEAF7EF),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: isDarkMode ? Colors.lightBlueAccent : Colors.blue,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "Stay updated with the latest ASF information from the DA and BAI",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: isDarkMode ? Colors.white70 : Colors.black87,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLink(BuildContext context, String title, String url) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[800]!.withValues(alpha: 0.3) : const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () async {
            final uri = Uri.parse(url);
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri, mode: LaunchMode.externalApplication);
            } else {
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Could not open $title',
                      style: GoogleFonts.poppins(),
                    ),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              children: [
                Icon(
                  Icons.link_rounded,
                  color: isDarkMode ? Colors.lightBlueAccent : const Color(0xFF1976D2),
                  size: 20,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: isDarkMode ? Colors.lightBlueAccent : const Color(0xFF1976D2),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Icon(
                  Icons.open_in_new_rounded,
                  color: isDarkMode ? Colors.grey[600] : Colors.grey[400],
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showQuickTipsDialog(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: isDarkMode ? const Color(0xFF2A2A2A) : Colors.white,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isDarkMode ? Colors.grey[800] : const Color(0xFFEAF7EF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.lightbulb_outline,
                        color: Color(0xff47b97f),
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        "Quick ASF Prevention Tips",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: isDarkMode ? Colors.white : const Color(0xFF2C6E49),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildQuickTipItem(context, "1", "Install footbaths with disinfectant at all entry points to your farm"),
                _buildQuickTipItem(context, "2", "Keep records of all pig movements, health checks, and visitors"),
                _buildQuickTipItem(context, "3", "Prohibit swill feeding to reduce disease transmission risk"),
                _buildQuickTipItem(context, "4", "Quarantine new pigs for at least 30 days before introducing to herd"),
                _buildQuickTipItem(context, "5", "Report any suspicions of ASF to local authorities immediately"),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.grey[800]!.withValues(alpha: 0.5): const Color(0xFFEFF8F1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isDarkMode ? Colors.grey[700]! : const Color(0xFFDCEDC8),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.contacts_outlined,
                        color: Color(0xff47b97f),
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Emergency Contact:",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: isDarkMode ? Colors.white70 : Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Phone: +63 0917 792 2480\n",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: isDarkMode ? Colors.white70 : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),


                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff47b97f),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: Text(
                      "Got it!",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickTipItem(BuildContext context, String number, String tip) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: const Color(0xff47b97f),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              tip,
              style: GoogleFonts.poppins(
                fontSize: 15,
                height: 1.5,
                color: isDarkMode ? Colors.white70 : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _emergencyResponseContent(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "If ASF is suspected on your farm, quick action is critical. Having an emergency response plan ready can help contain the outbreak and minimize losses.",
            style: GoogleFonts.poppins(
                fontSize: 16,
                color: isDarkMode ? Colors.white70 : Colors.black87,
                height: 1.5),
          ),
          const SizedBox(height: 16),
          _buildImageCard(
              context,
              "assets/images/preventingafricanswinefeverimages/ASFPLAN.jpg",
              "Emergency response team in protective gear"),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.red.withValues(alpha: 0.2) : Colors.red[50],
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDarkMode ? Colors.red[900]! : Colors.red[200]!,
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Immediate Steps if ASF is Confirmed:",
                  style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black87),
                ),
                const SizedBox(height: 12),
                _buildEmergencyStep(context, "1", "Immediately stop all pig movements to and from the farm"),
                _buildEmergencyStep(context, "2", "Notify local veterinary authorities and follow their guidance"),
                _buildEmergencyStep(context, "3", "Implement strict access control - no visitors to the farm"),
                _buildEmergencyStep(context, "4", "Disinfect all areas, equipment, vehicles thoroughly"),
                _buildEmergencyStep(context, "5", "Follow official guidelines for safe disposal of affected animals"),
                _buildEmergencyStep(context, "6", "Maintain detailed records of all actions taken"),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Farm Recovery Protocol:",
            style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black87),
          ),
          const SizedBox(height: 12),
          Text(
            "After an ASF outbreak, your farm must undergo thorough cleaning, disinfection, and a rest period before introducing new pigs:",
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: isDarkMode ? Colors.white70 : Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.grey[800] : Colors.grey[100],
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildRecoveryStep(context, Icons.cleaning_services,
                    "Cleaning: Remove all organic material and thoroughly clean all surfaces"),
                _buildRecoveryStep(context, Icons.sanitizer,
                    "Disinfection: Apply approved disinfectants to all areas and equipment"),
                _buildRecoveryStep(context, Icons.timer,
                    "Downtime: Allow a minimum of 40 days before restocking"),
                _buildRecoveryStep(context, Icons.restart_alt,
                    "Repopulation: Introduce a small number of sentinel pigs first"),
                _buildRecoveryStep(context, Icons.monitor_heart,
                    "Monitoring: Observe sentinel pigs for at least 60 days before full restocking"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyStep(BuildContext context, String number, String text) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.red[800] : Colors.red[600],
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: isDarkMode ? Colors.white70 : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecoveryStep(BuildContext context, IconData icon, String text) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 24,
            color: isDarkMode ? Colors.green[300] : Colors.green[700],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Add this custom clipper class outside the main widget class
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);

    var firstControlPoint = Offset(size.width / 4, size.height - 30);
    var firstEndPoint = Offset(size.width / 2, size.height - 20);
    path.quadraticBezierTo(
        firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(size.width - (size.width / 4), size.height - 10);
    var secondEndPoint = Offset(size.width, size.height - 30);
    path.quadraticBezierTo(
        secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// Add this new class for the detail page
class DetailPage extends StatelessWidget {
  final String title;
  final Widget content;

  const DetailPage({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF1E1E1E) : const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xff47b97f),
        elevation: 2,
        title: Hero(
          tag: 'section_$title',
          child: Material(
            color: Colors.transparent,
            child: Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: AnimatedOpacity(
            opacity: 1.0,
            duration: const Duration(milliseconds: 300),
            child: content,
          ),
        ),
      ),
    );
  }
}

// Add the FadePageRoute class
class FadePageRoute<T> extends MaterialPageRoute<T> {
  FadePageRoute({required WidgetBuilder builder}) : super(builder: builder);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);

  @override
  Widget buildTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
