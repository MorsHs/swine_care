import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:swine_care/colors/ArgieColors.dart';
import 'package:swine_care/colors/ArgieSizes.dart';
import 'package:url_launcher/url_launcher.dart';

// Custom FadePageRoute for smooth transitions
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

class BestPracticesPage extends StatelessWidget {
  const BestPracticesPage({super.key});

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode ? ArgieColors.dark : const Color(0xFFF5F7F1),
      appBar: AppBar(
        backgroundColor: Color(0xff6da4ed),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Iconsax.arrow_circle_left, color: Colors.white),
          onPressed: () => context.go('/guide'),
        ),
        title: Text(
          "Best Practices",
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(ArgieSizes.paddingDefault),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(context, "Starting Your Farm"),
            _buildPracticeCard(
              context: context,
              title: "1. Choose the Right Location",
              imagePath: "assets/images/bestpracticesimages/RightLocation.jpg",
              content: "• Good drainage & clean water access\n"
                  "• Avoid flood-prone zones\n"
                  "• Keep 3 km from highways, 1 km from towns\n"
                  "Example: Bulacan farms reduced disease by staying rural.",
              tip: "Tip: Check local zoning laws before building.",
              fullDescription: _locationDescription,
              key: ValueKey("card_location"),
            ),
            _buildPracticeCard(
              context: context,
              title: "2. Select Healthy Breeds",
              imagePath: "assets/images/bestpracticesimages/HealthyBreeds.jpg",
              content: "• Try Landrace, Duroc, or Yorkshire\n"
                  "• Buy from certified breeders\n"
                  "Tip: Crossbreeding boosts carcass quality.",
              tip: "Tip: Visit breeders to see pig health firsthand.",
              fullDescription: _breedsDescription,
              key: ValueKey("card_breeds"),
            ),
            _buildPracticeCard(
              context: context,
              title: "3. Build Proper Pens",
              imagePath:
              "assets/images/bestpracticesimages/ProperInfrastructure.jpg",
              content: "• 4m² space per adult pig\n"
                  "• Add ventilation & waste systems\n"
                  "• Use footbaths for biosecurity\n"
                  "Warning: Bad setup risks disease.",
              tip: "Tip: Design pens for easy cleaning and access.",
              fullDescription: _pensDescription,
              key: ValueKey("card_pens"),
            ),
            SizedBox(height: ArgieSizes.spaceBtwSections),
            _buildSectionTitle(context, "Managing Your Farm"),
            _buildPracticeCard(
              context: context,
              title: "1. Daily Feeding",
              imagePath: "assets/images/bestpracticesimages/FeedingRoutine.jpg",
              content: "• Growers (20-50kg): 16-18% protein\n"
                  "• Finishers (50-100kg): 14-16% protein\n"
                  "• Ensure clean water with nipple drinkers.",
              tip: "Tip: Monitor feed intake to adjust portions.",
              fullDescription: _feedingDescription,
              key: ValueKey("card_feeding"),
            ),
            _buildPracticeCard(
              context: context,
              title: "2. Prevent Disease",
              imagePath:
              "assets/images/bestpracticesimages/DiseasePrevention.jpg",
              content: "• Vaccinate for cholera & ASF\n"
                  "• Quarantine new pigs (30 days)\n"
                  "Example: Cebu farms track health digitally.",
              tip: "Tip: Keep a vaccination schedule calendar.",
              fullDescription: _diseaseDescription,
              key: ValueKey("card_disease"),
            ),
            _buildPracticeCard(
              context: context,
              title: "3. Keep It Clean",
              imagePath:
              "assets/images/bestpracticesimages/HygieneSanitation.jpg",
              content: "• Clean daily, disinfect weekly\n"
                  "• Use footbaths for all\n"
                  "Warning: Dirty pens = losses.",
              tip: "Tip: Rotate disinfectants to prevent resistance.",
              fullDescription: _cleanDescription,
              key: ValueKey("card_clean"),
            ),
            _buildPracticeCard(
              context: context,
              title: "4. Track Growth",
              imagePath:
              "assets/images/bestpracticesimages/MonitoringGrowth.jpg",
              content: "• Weigh pigs regularly\n"
                  "• Use apps for records\n"
                  "Tip: Early detection saves trouble.",
              tip: "Tip: Set reminders for regular health checks.",
              fullDescription: _growthDescription,
              key: ValueKey("card_growth"),
            ),
            SizedBox(height: ArgieSizes.spaceBtwSections),
            _buildTipsSection(context),
            _buildLinksSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.only(bottom: ArgieSizes.spaceBtwItems),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: isDarkMode ? ArgieColors.textthird : ArgieColors.textBold,
        ),
      ),
    );
  }

  Widget _buildPracticeCard({
    required BuildContext context,
    required String title,
    required String imagePath,
    required String content,
    required String tip,
    required String fullDescription,
    Key? key,
  }) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          FadePageRoute(
            builder: (context) => PracticeDetailPage(
              title: title,
              imagePath: imagePath,
              fullDescription: fullDescription,
            ),
          ),
        );
      },
      child: Card(
        key: key,
        color: isDarkMode ? ArgieColors.darkAccent : Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: EdgeInsets.only(bottom: ArgieSizes.spaceBtwItems),
        child: Padding(
          padding: EdgeInsets.all(ArgieSizes.paddingSmall),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: title,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    imagePath,
                    width: double.infinity,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: ArgieSizes.spaceBtwItems),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? ArgieColors.textthird : ArgieColors.textBold,
                ),
              ),
              SizedBox(height: ArgieSizes.spaceBtwItems / 2),
              Text(
                content,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: isDarkMode ? ArgieColors.textsecondary : ArgieColors.textprimary,
                  height: 1.5,
                ),
              ),
              SizedBox(height: ArgieSizes.spaceBtwItems),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          tip,
                          style: GoogleFonts.poppins(
                            color: isDarkMode ? ArgieColors.textthird : ArgieColors.textBold,
                          ),
                        ),
                        backgroundColor: ArgieColors.primary,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        margin: const EdgeInsets.all(16),
                      ),
                    );
                  },
                  icon: Icon(Icons.info_outline, color: ArgieColors.primary),
                  label: Text(
                    "Quick Tip",
                    style: GoogleFonts.poppins(color: ArgieColors.primary),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTipsSection(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: isDarkMode ? ArgieColors.darkAccent : const Color(0xFFFFF3E0),
      child: Padding(
        padding: EdgeInsets.all(ArgieSizes.paddingDefault),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Quick Tips for Success",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? ArgieColors.textthird : ArgieColors.textBold,
              ),
            ),
            SizedBox(height: ArgieSizes.spaceBtwItems),
            _buildTipItem(context, Icons.check_circle, "Start small, grow steady."),
            _buildTipItem(context, Icons.check_circle, "Train your team well."),
            _buildTipItem(context, Icons.check_circle, "Use apps for records."),
            _buildTipItem(context, Icons.check_circle, "Ask vets for help."),
          ],
        ),
      ),
    );
  }

  Widget _buildTipItem(BuildContext context, IconData icon, String text) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ArgieSizes.spaceBtwItems / 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: ArgieColors.primary, size: 20),
          SizedBox(width: ArgieSizes.spaceBtwItems),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: isDarkMode ? ArgieColors.textsecondary : ArgieColors.textprimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLinksSection(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: isDarkMode ? ArgieColors.darkAccent : Colors.white,
      child: Padding(
        padding: EdgeInsets.all(ArgieSizes.paddingDefault),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Learn More",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? ArgieColors.textthird : ArgieColors.textBold,
              ),
            ),
            SizedBox(height: ArgieSizes.spaceBtwItems),
            _buildLinkItem(
                context,
                "Pig Farming in the Philippines: How to Start",
                "https://www.agrifarming.in/pig-farming-in-the-philippines-how-to-start#"),
            _buildLinkItem(
                context,
                "Piggery Business in the Philippines 2023",
                "https://filipinobusinesshub.com/piggery-business-in-the-philippines-2023/"),
          ],
        ),
      ),
    );
  }

  Widget _buildLinkItem(BuildContext context, String text, String url) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ArgieSizes.spaceBtwItems / 2),
      child: InkWell(
        onTap: () => _launchURL(url),
        child: Row(
          children: [
            Icon(Icons.link, color: ArgieColors.primary, size: 20),
            SizedBox(width: ArgieSizes.spaceBtwItems),
            Expanded(
              child: Text(
                text,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: isDarkMode ? ArgieColors.textfifth : ArgieColors.primary,
                  decoration: TextDecoration.underline,
                  decorationColor:
                  isDarkMode ? ArgieColors.textfifth : ArgieColors.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PracticeDetailPage extends StatelessWidget {
  final String title;
  final String imagePath;
  final String fullDescription;

  const PracticeDetailPage({
    super.key,
    required this.title,
    required this.imagePath,
    required this.fullDescription,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff6da4ed),
        title: Text(
          title,
          style: GoogleFonts.poppins(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(ArgieSizes.paddingDefault),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: title,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  imagePath,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: ArgieSizes.spaceBtwItems),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? ArgieColors.textthird : ArgieColors.textBold,
              ),
            ),
            SizedBox(height: ArgieSizes.spaceBtwItems),
            Text(
              fullDescription,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: isDarkMode ? ArgieColors.textsecondary : ArgieColors.textprimary,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const _locationDescription = """
Choosing the right location for your swine farm is crucial for its success. The site affects pig health, farm efficiency, and long-term sustainability. A poorly chosen location can increase disease risks and operational costs.

Key Considerations:
- Ensure the site has good drainage to avoid water accumulation, which can lead to muddy pens and health issues.
- Provide access to clean, reliable water sources for drinking and farm operations.
- Avoid flood-prone areas to protect your pigs and infrastructure from natural disasters.
- Maintain a distance of at least 3 km from highways and 1 km from towns to minimize disease exposure and noise stress.

Example: Farms in Bulacan have reduced disease rates by situating their operations in rural areas, far from urban centers.

Tips:
- Research local zoning laws and secure necessary permits before construction.
- Choose slightly elevated land for better air circulation and drainage.
- Plan for proximity to feed suppliers and veterinary services to reduce transport costs.
""";

const _breedsDescription = """
Selecting healthy pig breeds sets the foundation for a productive farm. The breed impacts growth rates, meat quality, and resilience to local conditions.

Recommended Breeds:
- Landrace: Excellent for breeding due to high fertility and maternal instincts.
- Duroc: Known for rapid growth and superior meat quality.
- Yorkshire: Adaptable and hardy, suitable for various climates.

Best Practices:
- Source pigs from certified breeders to guarantee health and genetic quality.
- Experiment with crossbreeding to enhance traits like growth speed and carcass quality.

Tips:
- Visit breeders to inspect pig health and living conditions before purchasing.
- Ask for vaccination records and health certificates.
- Start with a small batch to test compatibility with your farm setup.
""";

const _pensDescription = """
Well-designed pens are vital for pig comfort, health, and farm management. Proper infrastructure reduces stress and disease, improving overall productivity.

Design Guidelines:
- Allocate at least 4m² per adult pig to prevent overcrowding.
- Install ventilation systems to maintain air quality and reduce humidity.
- Include waste management systems to keep pens clean and hygienic.
- Use footbaths at entry points to enhance biosecurity.

Warning: Inadequate pen design can increase disease spread and lower growth rates.
Tips:
- Use durable, easy-to-clean materials like concrete for pen floors.
- Add shaded areas to protect pigs from heat stress.
- Regularly check pens for structural damage and repair promptly.
""";

const _feedingDescription = """
Proper feeding ensures healthy growth and optimal meat production. Nutritional needs vary by growth stage, so adjust diets accordingly.

Feeding Guidelines:
- Growers (20-50kg): Feed 16-18% protein to support muscle development.
- Finishers (50-100kg):** Use 14-16% protein to enhance fat and meat quality.
- Provide clean water via nipple drinkers to keep pigs hydrated.

Tips:
- Observe feed consumption to fine-tune portion sizes and reduce waste.
- Use high-quality commercial feeds or consult a nutritionist for custom blends.
- Supplement diets with vitamins for breeding pigs to boost reproductive health.
""";

const _diseaseDescription = """
Preventing disease is essential to avoid losses and maintain a thriving farm. Proactive measures can significantly lower health risks.

Prevention Strategies:
- Vaccinate against diseases like cholera and African Swine Fever (ASF).
- Quarantine new pigs for 30 days to monitor for illness.
- Use digital tools to track health and vaccination schedules.

Example: Cebu farms have reduced outbreaks by adopting digital health monitoring.

Tips:
- Create and follow a strict vaccination calendar.
- Train staff to spot early disease signs, such as lethargy or reduced appetite.
- Limit farm visitors and enforce biosecurity protocols.
""";

const _cleanDescription = """
Cleanliness is a key factor in swine health and farm success. A hygienic environment prevents disease and promotes well-being.

Cleaning Protocols:
- Remove waste daily to keep pens sanitary.
- Disinfect pens and equipment weekly with effective solutions.
- Require footbaths for everyone entering the farm.

Warning: Poor hygiene can lead to disease outbreaks and financial setbacks.

Tips:
- Alternate disinfectants to prevent pathogen resistance.
- Assign separate tools for different farm zones to avoid contamination.
- Educate workers on proper cleaning methods and their importance.
""";

const _growthDescription = """
Tracking pig growth helps you monitor health and optimize farm performance. Regular checks allow for timely adjustments to care and feeding.

Monitoring Practices:
- Weigh pigs periodically to assess growth progress.
- Use mobile apps or notebooks to log health and growth data.

Tips:
- Schedule regular weigh-ins and health checks with reminders.
- Review growth trends to improve feeding and management strategies.
- Consult veterinarians with your records for expert guidance.
""";