import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swine_care/feature/guide/presentation/widgets/BackButton.dart';
import 'package:url_launcher/url_launcher.dart';

class SwineFarmingPage extends StatelessWidget {
  const SwineFarmingPage({super.key});

  // Function to launch URLs
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Button
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackButtonToGuidePage(),
                ],
              ),
              const SizedBox(height: 20),

              // Slideshow Header
              _buildSlideshowHeader(),

              const SizedBox(height: 20),
              // Section Header
              _buildSectionHeader("Good Animal Husbandry Practices for Swine"),
              _buildImageContainer("assets/images/swinefarmingimages/HusbandryPractices.jpg"),
              _buildDescriptionText(
                "The Philippine National Standard (PNS) Code of Good Animal Husbandry Practices (GAHP) ensures safe and sustainable swine farming. "
                    "Key principles include:\n\n"
                    "• Farm Location: At least 3 km from national highways and 1 km from built-up areas.\n"
                    "• Biosecurity Measures: Implement quarantine protocols for new pigs and control stray animals.\n"
                    "• Environmental Management: Prevent pollution by managing waste properly.\n"
                    "• Animal Welfare: Provide adequate space, clean water, and proper nutrition.\n\n"
                    "Example: A farm in Bulacan reduced disease outbreaks by implementing strict biosecurity and waste management practices.",
              ),

              // Guide Items
              _buildGuideItem(
                title: "Provide Clean Water Daily",
                description:
                "Pigs require clean, potable water at all times. Use nipple drinkers to ensure easy access.\n\n"
                    "Practical Tips:\n"
                    "• Test water quality at least once at the start of production.\n"
                    "• Clean water pipes regularly to prevent biofilm buildup.\n"
                    "• Maintain water pressure for nipple drinkers to avoid obstruction.\n\n"
                    "Example: A Pampanga farm improved growth rates by ensuring a continuous supply of clean water.",
                imagePath: "assets/images/swinefarmingimages/cleanwater.jpg",
                context: context,
              ),
              _buildGuideItem(
                title: "Maintain Proper Hygiene",
                description:
                "Hygiene is critical to prevent disease outbreaks:\n\n"
                    "1. Daily: Remove manure and leftover feed.\n"
                    "2. Weekly: Disinfect with potassium peroxymonosulfate (1:200 dilution).\n"
                    "3. Monthly: Full pen cleaning with pressure washer.\n\n"
                    "Biosecurity Measures:\n"
                    "• Install footbaths with disinfectant at entry points.\n"
                    "• Restrict visitors and ensure they wear protective clothing.\n\n"
                    "Example: A Batangas farm contained cholera by implementing footbaths and restricting visitor access.",
                imagePath: "assets/images/swinefarmingimages/hygiene.jpg",
                context: context,
              ),
              _buildGuideItem(
                title: "Ensure a Balanced Diet",
                description:
                "Optimal feed composition:\n\n"
                    "• Growers (20-50kg): 16-18% protein, 3,200 kcal/kg\n"
                    "• Finishers (50-100kg): 14-16% protein, 3,100 kcal/kg\n"
                    "• Sows: Add 1% calcium supplement during lactation\n\n"
                    "Feeding Management:\n"
                    "• Follow a 'first in – first out' rule for feed storage.\n"
                    "• Avoid banned drugs or additives in medicated feeds.\n"
                    "• Store medicated feed separately from non-medicated feed.\n\n"
                    "Warning: Swill feeding is prohibited unless heated to 90°C for 60 minutes.",
                imagePath: "assets/images/swinefarmingimages/pigfood.jpg",
                context: context,
              ),
              _buildGuideItem(
                title: "Monitor for Diseases",
                description:
                "Critical signs to watch:\n\n"
                    "Emergency Symptoms:\n"
                    "• Blueish ears (possible ASF)\n"
                    "• Sudden deaths with bloody diarrhea\n"
                    "• High fever (>40°C)\n\n"
                    "Prevention Protocol:\n"
                    "• Vaccinate against hog cholera every 6 months.\n"
                    "• Deworm every 3 months (use ivermectin 0.3mg/kg).\n"
                    "• Quarantine new pigs for 30 days.\n\n"
                    "Example: A cooperative in Cebu uses a digital system to track vaccination schedules and health records.",
                imagePath: "assets/images/swinefarmingimages/disease_monitoring.jpg",
                context: context,
              ),

              const SizedBox(height: 10),

              // Stack Widget for Breed Selection
              _buildStackedContent(),

              const SizedBox(height: 30),

              // Links Section
              Text(
                "For more info, please visit the links below:",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              _buildLink(
                text: "Code of Good Animal Husbandry Practices for Swine",
                url: "https://pcsp.org.ph/wp-content/uploads/2019/06/Correct-final-draft-GAHP-for-Swine.pdf",
              ),
              const SizedBox(height: 10),
              _buildLink(
                text: "Swine Raising Tips and Best Practices",
                url: "https://cagayanvalley.da.gov.ph/wp-content/uploads/2018/02/swine.pdf",
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // Slideshow Header Widget
  Widget _buildSlideshowHeader() {
    return Container(
      height: 200,
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: PageView(
          children: [
            _buildSlideshowImage("assets/images/swinefarmingimages/animalwelfare.jpg", "Selecting the Right Breed"),
            _buildSlideshowImage("assets/images/swinefarmingimages/pigbreeding.jpg", "Breeding Management"),
            _buildSlideshowImage("assets/images/swinefarmingimages/keeping-piglets-warm.jpg", "Caring for Piglets"),
            _buildSlideshowImage("assets/images/swinefarmingimages/pig1.jpg", "Maintain Swine"),
            _buildSlideshowImage("assets/images/swinefarmingimages/native-pigs.jpg", "Native Pigs"),
            _buildSlideshowImage("assets/images/swinefarmingimages/pig3.jpg", "Pig Progress"),
          ],
        ),
      ),
    );
  }

  // Slideshow Image Widget
  Widget _buildSlideshowImage(String imagePath, String label) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
        Positioned(
          bottom: 10,
          left: 10,
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              backgroundColor: Colors.black54,
            ),
          ),
        ),
      ],
    );
  }

  // Stack Widget for Breed Selection
  Widget _buildStackedContent() {
    return Stack(
      alignment: Alignment.center,
      children: [
        _buildImageContainer("assets/images/swinefarmingimages/RightBreed.jpg"),
        Positioned(
          bottom: 20,
          child: ElevatedButton(
            onPressed: () async {
              const String url = "https://philjournalsci.dost.gov.ph/images/pdf/pjs_pdf/vol151no5/genetic_diversity_of_Phil_native_pig_from_Quezon_and_Marinduque_.pdf";
              if (await canLaunchUrl(Uri.parse(url))) {
                await launchUrl(Uri.parse(url));
              } else {
                print("Could not launch $url");
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pinkAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            ),
            child: Text(
              "Learn More About Breeds",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Section Header Widget
  Widget _buildSectionHeader(String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  // Image Container Widget
  Widget _buildImageContainer(String imagePath) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            Image.asset(
              imagePath,
              width: double.infinity,
              height: 140,
              fit: BoxFit.cover,
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withValues(alpha: 0.4), Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Description Text Widget
  Widget _buildDescriptionText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 16,
          color: Colors.black54,
        ),
      ),
    );
  }

  // Guide Item Widget
  Widget _buildGuideItem({
    required String title,
    required String description,
    required String imagePath,
    required BuildContext context,
  }) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Scaffold(
                appBar: AppBar(
                  title: Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: imagePath,
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
                      const SizedBox(height: 16),
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        description,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(15),
        splashColor: Colors.pinkAccent.withValues(alpha: 0.2),
        highlightColor: Colors.pinkAccent.withValues(alpha: 0.1),
        child: Container(
          height: 120,
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              // Image with Shadow and Border
              Hero(
                tag: imagePath,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Text Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.black54,
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

  // Link Widget
  Widget _buildLink({required String text, required String url}) {
    return InkWell(
      onTap: () => _launchURL(url),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 16,
          color: Colors.blue,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}