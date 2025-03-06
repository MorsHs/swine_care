import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
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
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F1),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4CAF50),
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
                const SnackBar(content: Text("Added to Favorites!")),
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
            // Starting a Swine Farm Section
            _buildSectionHeader("Starting Your Farm"),
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

            // Managing a Swine Farm Section
            _buildSectionHeader("Managing Your Farm"),
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

            // Tips Section
            _buildTipsSection(),

            // Links Section
            _buildLinksSection(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Quick Note Saved!")),
          );
        },
        backgroundColor: const Color(0xFF4CAF50),
        child: const Icon(Icons.note_add),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF8BC34A), // Light green
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
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

  // Expandable Section with Image
  Widget _buildExpandableSectionWithImage({
    required BuildContext context,
    required String title,
    required String imagePath,
    required String content,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: CircleAvatar(
            backgroundColor: const Color(0xFF4CAF50),
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
              color: Colors.black87,
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
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Saved $title tip!")),
                      );
                    },
                    icon: const Icon(Icons.bookmark_border),
                    label: const Text("Save Tip"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF9800), // Orange for action
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

  // Tips Section
  Widget _buildTipsSection() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: const Color(0xFFFFF3E0), // Warm light orange
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
                color: const Color(0xFF4CAF50),
              ),
            ),
            const SizedBox(height: 12),
            _buildTipItem(Icons.check_circle, "Start small, grow steady."),
            _buildTipItem(Icons.check_circle, "Train your team well."),
            _buildTipItem(Icons.check_circle, "Use apps for records."),
            _buildTipItem(Icons.check_circle, "Ask vets for help."),
          ],
        ),
      ),
    );
  }

  // Tip Item
  Widget _buildTipItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF4CAF50), size: 20),
          const SizedBox(width: 10),
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

  // Links Section
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
              "Pig Farming in the Philippines: How to Start",
              "https://www.agrifarming.in/pig-farming-in-the-philippines-how-to-start#",
            ),
            _buildLinkItem(
              "Piggery Business in the Philippines 2023",
              "https://filipinobusinesshub.com/piggery-business-in-the-philippines-2023/",
            ),
          ],
        ),
      ),
    );
  }

  // Link Item
  Widget _buildLinkItem(String text, String url) {
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
                  color: const Color(0xFF2196F3),
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