import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:swine_care/colors/ArgieColors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

class EmergencyMeasuresPage extends StatefulWidget {
  const EmergencyMeasuresPage({super.key});

  @override
  _EmergencyMeasuresPageState createState() => _EmergencyMeasuresPageState();
}

class _EmergencyMeasuresPageState extends State<EmergencyMeasuresPage> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final ScrollController _scrollController;
  final List<GlobalKey> _sectionKeys = List.generate(6, (_) => GlobalKey());

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..forward();

    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
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
              'Could not launch $url',
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            ),
            backgroundColor: ArgieColors.primary.withValues(alpha: 0.9),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      }
    }
  }

  void _scrollToSection(int index) {
    if (_sectionKeys.length > index) {
      Scrollable.ensureVisible(
        _sectionKeys[index].currentContext!,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF1E1E1E) : const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xffb0b422),
        elevation: 2,
        title: Text(
          'Emergency Measures for Pigs',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_circle_left, color: Colors.white),
          onPressed: () => context.go('/guide'),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderCard(context),
            const SizedBox(height: 20),
            _buildEmergencyAlertBanner(context),
            const SizedBox(height: 20),
            _buildActionCard(
              context,
              "Immediate Actions",
              _buildImmediateActionsContent(context),
              'assets/images/emergencymeasuresimages/quarantinesetup.jpg',
              "Quarantine pen setup",
              key: _sectionKeys[0],
            ),
            const SizedBox(height: 20),
            _buildActionCard(
              context,
              "Emergency Measures",
              _buildEmergencyMeasuresContent(context),
              'assets/images/emergencymeasuresimages/EmergencyMeasures.jpg',
              "Recovery phase",
              key: _sectionKeys[1],
            ),
            const SizedBox(height: 20),
            _buildActionCard(
              context,
              "Disease Specific Protocols",
              _buildDiseaseProtocolsContent(context),
              'assets/images/emergencymeasuresimages/disinfection.jpg',
              "Disinfecting a pig pen",
              key: _sectionKeys[2],
            ),
            const SizedBox(height: 20),
            _buildActionCard(
              context,
              "Pig First Aid",
              _buildPigFirstAidContent(context),
              'assets/images/emergencymeasuresimages/EmergencyMeasures.jpg',
              "Emergency care for pigs",
              key: _sectionKeys[3],
            ),
            const SizedBox(height: 20),
            _buildTipsCard(context, key: _sectionKeys[4]),
            const SizedBox(height: 20),
            _buildRegulatoryComplianceCard(context, key: _sectionKeys[5]),
            const SizedBox(height: 20),
            _buildLinksCard(context),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCard(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xffb0b422).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.medical_services_rounded,
                  color: Color(0xffb0b422),
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Emergency Guide",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: isDarkMode ? Colors.white : Colors.black87,
                      ),
                    ),
                    Text(
                      "For Pig Health Crises",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            "Essential actions to take during pig health emergencies to protect your herd and farm investment",
            style: GoogleFonts.poppins(
              fontSize: 14,
              height: 1.5,
              color: isDarkMode ? Colors.white70 : Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  _showQuickTipsDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffb0b422),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: const Icon(Icons.tips_and_updates_outlined, size: 18),
                label: Text(
                  "Quick Tips",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              OutlinedButton.icon(
                onPressed: () {
                  _launchURL("https://www.facebook.com/davnorpvo");
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xffb0b422),
                  side: const BorderSide(color: Color(0xffb0b422), width: 1),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: const Icon(Icons.contact_support_outlined, size: 18),
                label: Text(
                  "Get Help",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyAlertBanner(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red[700],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.red,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ASF ALERT: HIGH RISK",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Cases reported in nearby provinces",
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "African Swine Fever (ASF) continues to be a major threat to pig farms. Implement strict biosecurity measures immediately.",
            style: GoogleFonts.poppins(
              fontSize: 14,
              height: 1.4,
              color: Colors.white.withValues(alpha: 0.95),
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () {
              _launchURL("https://www.sunstar.com.ph/davao/asf-affected-areas-in-davao-decline");
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.red[700],
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            icon: const Icon(Icons.map_outlined, size: 16),
            label: Text(
              "View Affected Areas",
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImmediateActionsContent(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildActionItem(
          context,
          "1. Isolate Sick Animals",
          "Immediately separate sick pigs from the healthy herd to prevent disease spread. Dedicate specific staff for handling the quarantined pigs to minimize cross-contamination.",
          Icons.do_not_disturb_on_outlined,
          Colors.red.shade700,
        ),
        _buildActionItem(
          context,
          "2. Contact Authorities",
          "Notify your local veterinary officer or the Department of Agriculture immediately. Report any suspected cases to allow for quick response and containment.",
          Icons.contact_phone_outlined,
          Colors.blue.shade700,
        ),
        _buildActionItem(
          context,
          "3. Restrict Farm Access",
          "Immediately implement strict biosecurity measures. No unauthorized personnel should enter or exit the premises. Place footbaths with disinfectant at all entry points.",
          Icons.no_accounts_outlined,
          Colors.orange.shade700,
        ),
        _buildActionItem(
          context,
          "4. Document Everything",
          "Record all details: symptoms observed, affected animals, timeline of events, and any other relevant information for authorities.",
          Icons.description_outlined,
          Colors.green.shade700,
        ),
        _buildActionItem(
          context,
          "5. Stop Animal Movement",
          "Cease all movement of pigs to and from your farm. Do not transport any pigs to markets or other farms until authorized by veterinary authorities.",
          Icons.block_outlined,
          Colors.purple.shade700,
        ),
        Container(
          margin: const EdgeInsets.only(top: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDarkMode
                ? Colors.amber.withValues(alpha: 0.15)
                : Colors.amber.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.amber.withValues(alpha: 0.5),
              width: 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.priority_high_rounded,
                color: Colors.amber[700],
                size: 22,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Important Note:",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: isDarkMode ? Colors.amber[300] : Colors.amber[800],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Early detection and rapid response are critical in limiting the spread of ASF. Do not wait for confirmation before taking these preventive actions.",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        height: 1.4,
                        color: isDarkMode ? Colors.white70 : Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEmergencyMeasuresContent(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildActionItem(
          context,
          "1. Establish Disinfection Zones",
          "Create clean and dirty zones on your farm with proper disinfection points between zones. Place footbaths with fresh disinfectant at all transition points.",
          Icons.clean_hands_outlined,
          Colors.teal.shade700,
        ),
        _buildActionItem(
          context,
          "2. Proper Disposal of Carcasses",
          "Follow official guidelines for safe disposal. Options include deep burial (at least 6 feet) with lime, incineration, or rendering as directed by authorities.",
          Icons.delete_outline,
          Colors.red.shade800,
        ),
        _buildActionItem(
          context,
          "3. Thorough Cleaning Protocol",
          "Remove all organic material from pig areas. Clean with soap and water before disinfecting. Pay special attention to food and water containers.",
          Icons.cleaning_services_outlined,
          Colors.blue.shade800,
        ),
        _buildActionItem(
          context,
          "4. Disinfection Process",
          "Use recommended virucidal disinfectants (e.g., 2% sodium hydroxide, 2% formaldehyde, or commercial products effective against ASF). Allow proper contact time.",
          Icons.sanitizer_outlined,
          Colors.green.shade800,
        ),
        _buildActionItem(
          context,
          "5. Staff Safety Measures",
          "Provide protective clothing to farm workers. Ensure proper handwashing and showering protocols before leaving infected areas.",
          Icons.person_outlined,
          Colors.orange.shade800,
        ),
        Container(
          margin: const EdgeInsets.only(top: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDarkMode
                ? Colors.blue.withValues(alpha: 0.15)
                : Colors.blue.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.blue.withValues(alpha: 0.05),
              width: 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.info_outline,
                color: Colors.blue[700],
                size: 22,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Expert Tip:",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: isDarkMode ? Colors.blue[300] : Colors.blue[800],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "ASF virus can survive in meat products for months and in blood at room temperature for up to 15 weeks. Thorough disinfection is crucial.",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        height: 1.4,
                        color: isDarkMode ? Colors.white70 : Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDiseaseProtocolsContent(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDiseaseProtocolItem(
          context,
          "African Swine Fever (ASF)",
          "Highly contagious viral disease with up to 100% mortality. No treatment or vaccine available.",
          [
            "Immediate culling of infected and contact animals",
            "Strict quarantine of the entire farm for at least 40 days",
            "Thorough cleaning with detergent followed by virucidal disinfectants",
            "Ban on restocking for at least 6 months in affected buildings"
          ],
          Colors.red.shade700,
        ),
        const SizedBox(height: 16),
        _buildDiseaseProtocolItem(
          context,
          "Foot and Mouth Disease (FMD)",
          "Highly contagious viral disease affecting cloven-hoofed animals. Causes fever and blisters.",
          [
            "Restrict movement of all animals and animal products",
            "Vaccination of susceptible animals in surrounding areas",
            "Disinfection of premises, vehicles, and equipment",
            "Recovery period of at least 3 months before introducing new animals"
          ],
          Colors.orange.shade700,
        ),
        const SizedBox(height: 16),
        _buildDiseaseProtocolItem(
          context,
          "Classical Swine Fever (CSF)",
          "Highly contagious viral disease with high mortality. Vaccination is available in some regions.",
          [
            "Immediate notification to veterinary authorities",
            "Implementation of stamping out policy if required",
            "Vaccination in buffer zones if approved by authorities",
            "Strict biosecurity for at least 30 days after last case"
          ],
          Colors.amber.shade700,
        ),
        const SizedBox(height: 16),
        _buildDiseaseProtocolItem(
          context,
          "Porcine Reproductive & Respiratory Syndrome (PRRS)",
          "Viral disease causing reproductive failure in breeding stock and respiratory issues in young pigs.",
          [
            "Isolate infected animals and implement strict all-in/all-out system",
            "Consider depopulation in severe cases",
            "Vaccination of healthy animals if available",
            "Enhanced biosecurity with filtered air systems if possible"
          ],
          Colors.blue.shade700,
        ),
        Container(
          margin: const EdgeInsets.only(top: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDarkMode
                ? Colors.green.withValues(alpha: 0.15)
                : Colors.green.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.green.withValues(alpha: 0.5),
              width: 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.check_circle_outline,
                color: Colors.green[700],
                size: 22,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Recovery Plan:",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: isDarkMode ? Colors.green[300] : Colors.green[800],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "For all disease outbreaks, develop a long-term recovery plan that includes financial considerations, phased restocking, and continued surveillance to prevent future outbreaks.",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        height: 1.4,
                        color: isDarkMode ? Colors.white70 : Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPigFirstAidContent(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildActionItem(
          context,
          "1. Wounds and Bleeding",
          "Clean the wound with mild antiseptic solution. Apply pressure to stop bleeding. For deep cuts, contact a veterinarian immediately.",
          Icons.healing,
          Colors.red.shade700,
        ),
        _buildActionItem(
          context,
          "2. Choking",
          "Open the pig's mouth and check for foreign objects. Use blunt-ended tools to carefully remove visible obstructions. Avoid pushing objects deeper.",
          Icons.air,
          Colors.orange.shade700,
        ),
        _buildActionItem(
          context,
          "3. Heat Stress",
          "Move pig to a cool, shaded area immediately. Spray with cool water (not cold). Provide fresh drinking water. Use fans to increase air movement.",
          Icons.thermostat,
          Colors.amber.shade700,
        ),
        _buildActionItem(
          context,
          "4. Farrowing Difficulties",
          "If a sow struggles with birthing for more than 30-60 minutes between piglets, contact a veterinarian. Keep the area clean and minimize stress.",
          Icons.pregnant_woman,
          Colors.purple.shade700,
        ),
        _buildActionItem(
          context,
          "5. Seizures",
          "Clear the area of objects that might injure the pig. Do not restrain the animal during a seizure. Note duration and symptoms for the veterinarian.",
          Icons.electric_bolt,
          Colors.blue.shade700,
        ),
        Container(
          margin: const EdgeInsets.only(top: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDarkMode
                ? Colors.teal.withValues(alpha: 0.15)
                : Colors.teal.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.teal.withValues(alpha: 0.5),
              width: 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.medical_services,
                color: Colors.teal[700],
                size: 22,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "First Aid Kit Essentials:",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: isDarkMode ? Colors.teal[300] : Colors.teal[800],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Keep thermometer, antiseptic solution, sterile gauze, bandages, scissors, tweezers, disposable gloves, and your veterinarian's contact information readily available.",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        height: 1.4,
                        color: isDarkMode ? Colors.white70 : Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionCard(BuildContext context, String title, Widget content, String imagePath, String imageCaption, {Key? key}) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: isDarkMode ? Colors.grey[800] : Colors.white,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            FadePageRoute(
              builder: (context) => EmergencyDetailPage(
                title: title,
                content: content,
                imagePath: imagePath,
                imageCaption: imageCaption,
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? Colors.white : Colors.black87,
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, color: Color(0xffb0b422), size: 16),
                ],
              ),
              const SizedBox(height: 15),
              Hero(
                tag: title, // Matches the Hero tag in the card
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    imagePath,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                imageCaption,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTipsCard(BuildContext context, {Key? key}) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: isDarkMode ? const Color(0xFF2A2A2A) : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Container(
                //   padding: const EdgeInsets.all(10),
                //   decoration: BoxDecoration(
                //     color: isDarkMode ? Colors.grey[800] : const Color(0xFFF5F5F5),
                //     borderRadius: BorderRadius.circular(12),
                //   ),
                //   child: const Icon(
                //     Icons.lightbulb_outline,
                //     color: Color(0xffb0b422),
                //     size: 18,
                //   ),
                // ),
                // const SizedBox(width: 16),
                Text(
                  "Pro Tips for Emergency Response",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? Colors.white : Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildTipItem(
                context,
                "1",
                "Keep emergency supplies in a designated, easily accessible location",
                isDarkMode
            ),
            _buildTipItem(
                context,
                "2",
                "Maintain updated contact information for veterinarians, authorities, and neighbors",
                isDarkMode
            ),
            _buildTipItem(
                context,
                "3",
                "Conduct regular drills with farm workers to practice emergency protocols",
                isDarkMode
            ),
            _buildTipItem(
                context,
                "4",
                "Document all farm activities, visitors, and pig movements for traceability",
                isDarkMode
            ),
            _buildTipItem(
                context,
                "5",
                "Consider insurance options that cover disease outbreaks for financial protection",
                isDarkMode
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? const Color(0xFF333333)
                    : const Color(0xFFFFF8E1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xffb0b422).withValues(alpha: 0.5),
                  width: 1,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.tips_and_updates_outlined,
                    color: isDarkMode
                        ? const Color(0xffb0b422)
                        : const Color(0xffb0b422),
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Farmer Success Story",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: isDarkMode ? Colors.white : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "A farm in Batangas successfully contained an ASF outbreak by immediately implementing their emergency plan. They resumed operations within 6 months by following proper protocols and maintaining strict biosecurity.",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            height: 1.5,
                            color: isDarkMode ? Colors.white70 : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipItem(BuildContext context, String number, String tip, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: const Color(0xffb0b422),
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

  Widget _buildLinksCard(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: isDarkMode ? const Color(0xFF2A2A2A) : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.grey[800] : const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.menu_book_outlined,
                    color: Color(0xffb0b422),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  "Helpful Resources",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? Colors.white : Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              "Access these valuable resources for emergency response guidance:",
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: isDarkMode ? Colors.white70 : Colors.black87,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            _buildResourceLink(context, "DA Emergency Response Guidelines",
                "https://www.da.gov.ph/programs-and-activities/african-swine-fever/"),
            _buildResourceLink(context, "BAI Animal Health Services",
                "https://www.bai.gov.ph/"),
            _buildResourceLink(context, "OIE ASF Situation Reports",
                "https://www.woah.org/en/disease/african-swine-fever/"),
            _buildResourceLink(context, "FAO ASF Action Plan",
                "https://www.fao.org/3/ca3632en/CA3632EN.pdf"),
            _buildResourceLink(context, "Local Veterinary Support Directory",
                "https://www.pvma.org.ph/"),
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
                  const Icon(
                    Icons.contact_phone_outlined,
                    color: Color(0xffb0b422),
                    size: 22,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Emergency Hotlines:",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: isDarkMode ? Colors.white : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Phone: +63 917 792 2480\n",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            height: 1.5,
                            color: isDarkMode ? Colors.white70 : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildResourceLink(BuildContext context, String title, String url) {
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
          onTap: () => _launchURL(url),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              children: [
                const Icon(
                  Icons.link_rounded,
                  color: Color(0xffb0b422),
                  size: 20,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: isDarkMode ? Colors.white : Colors.black87,
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
                        color: isDarkMode ? Colors.grey[800] : const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.tips_and_updates_outlined,
                        color: Color(0xffb0b422),
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        "Emergency Response Tips",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildQuickTipItem(context, "1", "Act within 24-48 hours of noticing symptoms for best containment results"),
                _buildQuickTipItem(context, "2", "Use dedicated clothing and equipment for quarantined areas only"),
                _buildQuickTipItem(context, "3", "Apply lime around farm perimeter to create a disinfection barrier"),
                _buildQuickTipItem(context, "4", "Conduct daily health checks on all animals during an outbreak"),
                _buildQuickTipItem(context, "5", "Maintain communication with nearby farms for regional containment"),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.grey[800]!.withValues(alpha: 0.5) : const Color(0xFFEFF8F1),
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
                        Icons.warning_amber_rounded,
                        color: isDarkMode
                            ? const Color(0xffb0b422)
                            : const Color(0xffb0b422),
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Remember:",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: isDarkMode ? Colors.white70 : Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "ASF is not transmissible to humans but can be carried on clothing and vehicles. Proper biosecurity is essential!",
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
                      backgroundColor: const Color(0xffb0b422),
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
            decoration: const BoxDecoration(
              color: Color(0xffb0b422),
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

  Widget _buildActionItem(BuildContext context, String title, String description, IconData icon, Color iconColor) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[800]!.withValues(alpha: 0.5) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.black12 : Colors.black.withValues(alpha: 0.5),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isDarkMode ? const Color(0xFF333333) : iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    height: 1.5,
                    color: isDarkMode ? Colors.white70 : Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiseaseProtocolItem(BuildContext context, String diseaseName, String description, List<String> protocols, Color accentColor) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[800]!.withValues(alpha: 0.5) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.black12 : Colors.black.withValues(alpha: 0.5),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.health_and_safety_outlined,
                  color: accentColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  diseaseName,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: isDarkMode ? Colors.white : Colors.black87,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: GoogleFonts.poppins(
              fontSize: 14,
              height: 1.5,
              color: isDarkMode ? Colors.white70 : Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Response Protocol:",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isDarkMode ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          ...protocols.map((protocol) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.circle,
                  size: 8,
                  color: accentColor,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    protocol,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      height: 1.5,
                      color: isDarkMode ? Colors.white70 : Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildRegulatoryComplianceCard(BuildContext context, {Key? key}) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: isDarkMode ? const Color(0xFF2A2A2A) : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.grey[800] : const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.gavel_rounded,
                    color: Colors.blue[700],
                    size: 16,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  "Regulatory Compliance",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? Colors.white : Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              "During an emergency situation, it's important to comply with local and national regulations:",
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: isDarkMode ? Colors.white70 : Colors.black87,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            _buildComplianceItem(
              context,
              "Mandatory Reporting",
              "Certain diseases must be reported to agricultural authorities within 24 hours of suspicion.",
              Icons.report_outlined,
            ),
            _buildComplianceItem(
              context,
              "Movement Restrictions",
              "Do not transport animals during disease outbreaks without authorization from authorities.",
              Icons.not_listed_location_outlined,
            ),
            _buildComplianceItem(
              context,
              "Disposal Regulations",
              "Follow environmental regulations for safe carcass disposal to prevent groundwater contamination.",
              Icons.delete_outline,
            ),
            _buildComplianceItem(
              context,
              "Record Keeping",
              "Maintain detailed records of all animals, treatments, and actions taken during the emergency.",
              Icons.description_outlined,
            ),
            _buildComplianceItem(
              context,
              "Compensation Claims",
              "Document all losses thoroughly for potential government compensation programs.",
              Icons.monetization_on_outlined,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.blue.withValues(alpha: 0.15) : Colors.blue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.blue.withValues(alpha: 0.5),
                  width: 1,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.policy_outlined,
                    color: Colors.blue[700],
                    size: 22,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Legal Advisory:",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: isDarkMode ? Colors.blue[300] : Colors.blue[800],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Failure to comply with regulations during a disease outbreak may result in penalties and loss of eligibility for compensation programs.",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            height: 1.5,
                            color: isDarkMode ? Colors.white70 : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComplianceItem(BuildContext context, String title, String description, IconData icon) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[800]!.withValues(alpha: 0.3) : Colors.grey[100]!,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Colors.blue[700],
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    height: 1.5,
                    color: isDarkMode ? Colors.white70 : Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAccessButton(BuildContext context, String title, int index, IconData icon) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.pop(context);
          _scrollToSection(index);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isDarkMode ? Colors.grey[800] : const Color(0xFFF5F5F5),
          foregroundColor: isDarkMode ? Colors.white : Colors.black87,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.centerLeft,
        ),
        icon: Icon(icon, color: const Color(0xffb0b422)),
        label: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
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

// Add this class outside the main widget
class _ModernBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.1)
      ..style = PaintingStyle.fill;

    // Draw modern abstract shapes
    final path1 = Path()
      ..moveTo(size.width * 0.7, 0)
      ..quadraticBezierTo(size.width * 0.8, size.height * 0.3, size.width, size.height * 0.4)
      ..lineTo(size.width, 0)
      ..close();

    final path2 = Path()
      ..moveTo(0, size.height * 0.6)
      ..quadraticBezierTo(size.width * 0.3, size.height * 0.8, size.width * 0.6, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path1, paint);
    canvas.drawPath(path2, paint);

    // Draw some circles for a modern touch
    canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.2), 50, paint);
    canvas.drawCircle(Offset(size.width * 0.2, size.height * 0.3), 30, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


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

class EmergencyDetailPage extends StatelessWidget {
  final String title;
  final Widget content;
  final String imagePath;
  final String imageCaption;

  const EmergencyDetailPage({
    super.key,
    required this.title,
    required this.content,
    required this.imagePath,
    required this.imageCaption,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffb0b422),
        elevation: 6,
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: isDarkMode ? Colors.grey[900] : const Color(0xFFF0F4F8),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: title, // Matches the Hero tag in the card
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  imagePath,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              imageCaption,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
            const SizedBox(height: 20),
            content,
          ],
        ),
      ),
    );
  }
}