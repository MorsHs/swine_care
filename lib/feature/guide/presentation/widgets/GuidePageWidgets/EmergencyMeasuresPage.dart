import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:swine_care/colors/ArgieColors.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyMeasuresPage extends StatefulWidget {
  const EmergencyMeasuresPage({super.key});

  @override
  _EmergencyMeasuresPageState createState() => _EmergencyMeasuresPageState();
}

class _EmergencyMeasuresPageState extends State<EmergencyMeasuresPage> {
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
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

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.grey[900] : const Color(0xFFF0F4F8),
      appBar: AppBar(
        backgroundColor:  Color(0xffb0b422),
        elevation: 8,
        shadowColor: isDarkMode ? Colors.black45 : Colors.grey[400],
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_circle_left, color: Colors.white),
          onPressed: () => context.go('/guide'),
        ),
        title: Text(
          "Swine Emergency Guide",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),

      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderSection(context),
            const SizedBox(height: 25),
            _buildActionCard(
              context,
              "Immediate Actions",
              _buildImmediateActionsContent(context),
              'assets/images/emergencymeasuresimages/quarantinesetup.jpg',
              "Quarantine pen setup",
            ),
            const SizedBox(height: 20),
            _buildActionCard(
              context,
              "Emergency Measures",
              _buildEmergencyMeasuresContent(context),
              'assets/images/emergencymeasuresimages/EmergencyMeasures.jpg',
              "Recovery phase",
            ),
            const SizedBox(height: 20),
            _buildActionCard(
              context,
              "Emergency Protocols",
              _buildProtocolsContent(context),
              'assets/images/emergencymeasuresimages/disinfection.jpg',
              "Disinfecting a pig pen",
            ),
            const SizedBox(height: 20),
            _buildTipsCard(context),
            const SizedBox(height: 20),
            _buildLinksCard(context),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context) {
    //final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffbeb946), ArgieColors.secondary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Stay Prepared!",
              style: GoogleFonts.poppins(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Swift action is key to safeguarding your swine during emergencies.",
              style: GoogleFonts.poppins(
                fontSize: 18,
                color: Colors.white70,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                'assets/images/emergencymeasuresimages/StayPrepared.jpg',
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImmediateActionsContent(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            style: GoogleFonts.poppins(fontSize: 16, color: isDarkMode ? Colors.white70 : Colors.black87, height: 1.6),
            children: [
              const TextSpan(text: "When a disease outbreak strikes, act fast to protect your herd:\n\n"),
              const TextSpan(text: "1. Isolate Affected Pigs:\n"),
              TextSpan(
                text: "• Move sick pigs calmly using low-stress handling (e.g., boards, not sticks).\n"
                    "• Set up a quarantine pen at least 200 feet from healthy pigs.\n",
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              ),
              const TextSpan(text: "\n2. Contact Authorities:\n"),
              TextSpan(
                text: "• Call your local vet or animal health office immediately.\n"
                    "• Report symptoms like high fever or sudden deaths.\n",
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              ),
              const TextSpan(text: "\n3. Lock Down the Farm:\n"),
              TextSpan(
                text: "• Restrict all visitors and vehicles.\n"
                    "• Set up footbaths with disinfectant at entry points.\n",
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
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
        Text.rich(
          TextSpan(
            style: GoogleFonts.poppins(fontSize: 16, color: isDarkMode ? Colors.white70 : Colors.black87, height: 1.6),
            children: [
              const TextSpan(text: "Effective emergency measures are critical during swine farming crises:\n\n"),
              const TextSpan(text: "1. Preparation:\n"),
              TextSpan(
                text: "• Stockpile disinfectants, gloves, and masks.\n"
                    "• Train staff on emergency procedures.\n",
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              ),
              const TextSpan(text: "\n2. Response:\n"),
              TextSpan(
                text: "• Deploy quarantine zones within 1 hour of detection.\n"
                    "• Use PPE and avoid cross-contamination.\n",
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              ),
              const TextSpan(text: "\n3. Recovery:\n"),
              TextSpan(
                text: "• Clean and disinfect all areas post-outbreak.\n"
                    "• Repopulate gradually with vetted stock.\n",
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          "Success Story: A Quezon farm recovered from an ASF scare by isolating early and disinfecting, resuming operations in 3 months!",
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontStyle: FontStyle.italic,
            color: isDarkMode ? Colors.tealAccent[100] : Colors.green[700],
          ),
        ),
      ],
    );
  }

  Widget _buildProtocolsContent(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            style: GoogleFonts.poppins(fontSize: 16, color: isDarkMode ? Colors.white70 : Colors.black87, height: 1.6),
            children: [
              const TextSpan(text: "1. Disinfection Procedures:\n"),
              TextSpan(
                text: "• Wash pens with hot water, then apply disinfectants (e.g., Virkon-S or bleach).\n"
                    "• Disinfect boots, tools, and trailers after every use.\n",
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              ),
              const TextSpan(text: "\n2. Monitor Symptoms:\n"),
              TextSpan(
                text: "• Look for fever (>104°F), lameness, or bluish skin daily.\n"
                    "• Use a logbook or app to track health changes.\n",
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              ),
              const TextSpan(text: "\n3. Cull Infected Animals:\n"),
              TextSpan(
                text: "• If ASF is confirmed, cull humanely with vet oversight.\n"
                    "• Bury or incinerate carcasses per local rules.\n",
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              ),
              const TextSpan(text: "\nWarning: ASF has no treatment—focus on containment!"),
              TextSpan(
                text: "\nSuccess: A Manila farm reduced spread by 80% with strict culling protocols.",
                style: GoogleFonts.poppins(fontStyle: FontStyle.italic, color: isDarkMode ? Colors.tealAccent[100] : Colors.green[700]),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionCard(BuildContext context, String title, Widget content, String imagePath, String imageCaption) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? Colors.white : Colors.black87,
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, color: Color(0xffbeb946), size: 18),
                ],
              ),
              const SizedBox(height: 15),
              Hero(
                tag: title,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
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

  Widget _buildTipsCard(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: isDarkMode ? Colors.grey[700] : const Color(0xFFE8F5E9),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Pro Tips for Emergency Preparedness",
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: isDarkMode ? Colors.white : const Color(0xffbeb946),
              ),
            ),
            const SizedBox(height: 15),
            _buildTipItem(context, Icons.check_circle_outline, "Use herd behavior to move pigs efficiently."),
            _buildTipItem(context, Icons.check_circle_outline, "Stockpile a 3-day emergency supply."),
            _buildTipItem(context, Icons.check_circle_outline, "Conduct a mock drill with your team."),
            _buildTipItem(context, Icons.check_circle_outline, "Install motion sensors for wild boar alerts."),
            const SizedBox(height: 15),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                'assets/images/emergencymeasuresimages/ProTipsEmergency.jpg',
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Mock emergency drill in progress",
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
          ],
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
          Icon(icon, color: Color(0xffbeb946), size: 24),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(fontSize: 16, color: isDarkMode ? Colors.white70 : Colors.black87),
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
      color: isDarkMode ? Colors.grey[800] : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Learn More",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 15),
            _buildLinkItem(context, "ASF Emergency Guidelines (DA Philippines)", "https://www.da.gov.ph/african-swine-fever-asf/"),
            _buildLinkItem(context, "Swine Disease Management", "https://www.agriculture.com.ph/2022/08/10/a-guide-to-swine-raising-in-the-philippines/"),
            _buildLinkItem(context, "WHO ASF Protocols", "https://www.who.int/emergencies/diseases/african-swine-fever"),
          ],
        ),
      ),
    );
  }

  Widget _buildLinkItem(BuildContext context, String text, String url) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () => _launchURL(url),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Icon(Icons.launch, color: ArgieColors.primary, size: 22),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                text,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: isDarkMode ? Color(0xffb0b422) : Color(0xffbeb946),
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