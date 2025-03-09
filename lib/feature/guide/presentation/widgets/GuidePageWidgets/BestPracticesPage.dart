import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swine_care/colors/ArgieColors.dart';
import 'package:url_launcher/url_launcher.dart';

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
      backgroundColor: isDarkMode ? Colors.grey[850] : const Color(0xFFF5F7F1),
      appBar: AppBar(
        backgroundColor: ArgieColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go('/guide'),
        ),
        title: Text(
          "Best Practices",
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Added to Favorites!", style: TextStyle(color: isDarkMode ? Colors.white : Colors.black87))),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(context, "Starting Your Farm"),
            _buildExpandableSectionWithImage(
              context: context,
              title: "1. Choose the Right Location",
              imagePath: "assets/images/bestpracticesimages/RightLocation.jpg",
              content:
              "• Good drainage & clean water access\n"
                  "• Avoid flood-prone zones\n"
                  "• Keep 3 km from highways, 1 km from towns\n"
                  "Example: Bulacan farms reduced disease by staying rural.",
            ),
            _buildExpandableSectionWithImage(
              context: context,
              title: "2. Select Healthy Breeds",
              imagePath: "assets/images/bestpracticesimages/HealthyBreeds.jpg",
              content:
              "• Try Landrace, Duroc, or Yorkshire\n"
                  "• Buy from certified breeders\n"
                  "Tip: Crossbreeding boosts carcass quality.",
            ),
            _buildExpandableSectionWithImage(
              context: context,
              title: "3. Build Proper Pens",
              imagePath: "assets/images/bestpracticesimages/ProperInfrastructure.jpg",
              content:
              "• 4m² space per adult pig\n"
                  "• Add ventilation & waste systems\n"
                  "• Use footbaths for biosecurity\n"
                  "Warning: Bad setup risks disease.",
            ),
            const SizedBox(height: 20),
            _buildSectionHeader(context, "Managing Your Farm"),
            _buildExpandableSectionWithImage(
              context: context,
              title: "1. Daily Feeding",
              imagePath: "assets/images/bestpracticesimages/FeedingRoutine.jpg",
              content:
              "• Growers (20-50kg): 16-18% protein\n"
                  "• Finishers (50-100kg): 14-16% protein\n"
                  "• Ensure clean water with nipple drinkers.",
            ),
            _buildExpandableSectionWithImage(
              context: context,
              title: "2. Prevent Disease",
              imagePath: "assets/images/bestpracticesimages/DiseasePrevention.jpg",
              content:
              "• Vaccinate for cholera & ASF\n"
                  "• Quarantine new pigs (30 days)\n"
                  "Example: Cebu farms track health digitally.",
            ),
            _buildExpandableSectionWithImage(
              context: context,
              title: "3. Keep It Clean",
              imagePath: "assets/images/bestpracticesimages/HygieneSanitation.jpg",
              content:
              "• Clean daily, disinfect weekly\n"
                  "• Use footbaths for all\n"
                  "Warning: Dirty pens = losses.",
            ),
            _buildExpandableSectionWithImage(
              context: context,
              title: "4. Track Growth",
              imagePath: "assets/images/bestpracticesimages/MonitoringGrowth.jpg",
              content:
              "• Weigh pigs regularly\n"
                  "• Use apps for records\n"
                  "Tip: Early detection saves trouble.",
            ),
            const SizedBox(height: 20),
            _buildTipsSection(context),
            _buildLinksSection(context),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Quick Note Saved!", style: TextStyle(color: isDarkMode ? Colors.white : Colors.black87))),
          );
        },
        backgroundColor: ArgieColors.primary,
        child: const Icon(Icons.note_add),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: ArgieColors.primary,
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

  Widget _buildExpandableSectionWithImage({
    required BuildContext context,
    required String title,
    required String imagePath,
    required String content,
  }) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Card(
        color: isDarkMode ? Colors.grey[800] : Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: CircleAvatar(
            backgroundColor: ArgieColors.primary,
            child: Text(
              title.split(" ")[0],
              style: GoogleFonts.poppins(color: Colors.white),
            ),
          ),
          title: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: isDarkMode ? Colors.white70 : Colors.black87,
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      imagePath,
                      width: double.infinity,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    content,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: isDarkMode ? Colors.white70 : Colors.black87,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Saved $title tip!", style: TextStyle(color: isDarkMode ? Colors.white : Colors.black87))),
                      );
                    },
                    icon: const Icon(Icons.bookmark_border),
                    label: const Text("Save Tip"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ArgieColors.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
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

  Widget _buildTipsSection(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: isDarkMode ? Colors.grey[800] : const Color(0xFFFFF3E0),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Quick Tips for Success",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : const Color(0xff6da4ed),
              ),
            ),
            const SizedBox(height: 12),
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
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: ArgieColors.primary, size: 20),
          const SizedBox(width: 10),
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

  Widget _buildLinksSection(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: isDarkMode ? Colors.grey[800] : Colors.white,
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
                color: isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            _buildLinkItem(context, "Pig Farming in the Philippines: How to Start",
                "https://www.agrifarming.in/pig-farming-in-the-philippines-how-to-start#"),
            _buildLinkItem(context, "Piggery Business in the Philippines 2023",
                "https://filipinobusinesshub.com/piggery-business-in-the-philippines-2023/"),
          ],
        ),
      ),
    );
  }

  Widget _buildLinkItem(BuildContext context, String text, String url) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: InkWell(
        onTap: () => _launchURL(url),
        child: Row(
          children: [
            const Icon(Icons.link, color: Color(0xFF2196F3), size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                text,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: isDarkMode ? Colors.lightBlueAccent : const Color(0xFF2196F3),
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