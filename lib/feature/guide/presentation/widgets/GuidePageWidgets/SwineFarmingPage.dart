import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:swine_care/colors/ArgieColors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class SwineFarmingPage extends StatefulWidget {
  const SwineFarmingPage({super.key});

  @override
  _SwineFarmingPageState createState() => _SwineFarmingPageState();
}

class _SwineFarmingPageState extends State<SwineFarmingPage> {
  bool _showQuickTips = false;

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Could not launch $url', style: TextStyle(color: Theme.of(context).colorScheme.onSurface))));
    }
  }

  void _shareContent() {
    Share.share(
      'Check out this Swine Farming Guide! Learn best practices for healthy pigs: https://example.com/swine-guide',
      subject: 'Swine Farming Tips',
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.grey[850] : const Color(0xFFF5F5F0),
      appBar: AppBar(
        backgroundColor: Color(0xffec7c86),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go('/guide'),
        ),
        title: Text(
          "Swine Farming Guide",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: _shareContent,
            tooltip: "Share Guide",
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildSlideshowHeader(context),
          const SizedBox(height: 20),
          _buildSectionHeader(context, "Good Swine Farming"),
          _buildImageContainer(context, "assets/images/swinefarmingimages/HusbandryPractices.jpg"),
          _buildDescriptionText(context,
            "The Philippine National Standard (PNS) Code ensures safe, sustainable swine farming:\n\n"
                "• Farm Location: Set up 3 km from highways, 1 km from towns to avoid contamination.\n"
                "• Biosecurity: Quarantine new pigs for 30 days, fence out stray dogs and rats.\n"
                "• Waste Control: Use pits or composters to manage manure—no river dumping!\n"
                "• Pig Comfort: Provide 1.5-2 sqm per pig, fresh water, and shade.\n\n"
                "Success Story: A Bulacan farm cut disease by 70% with biosecurity and waste pits!",
          ),
          const Divider(color: Colors.grey, height: 30),
          ..._buildGuideItems(context),
          const Divider(color: Colors.grey, height: 30),
          _buildStackedContent(context),
          const SizedBox(height: 20),
          _buildQuickTipsToggle(context),
          if (_showQuickTips) _buildQuickTipsSection(context),
          const SizedBox(height: 30),
          _buildLinksSection(context),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildSlideshowHeader(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return CarouselSlider(
      options: CarouselOptions(
        height: 240,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.85,
        autoPlayInterval: const Duration(seconds: 4),
      ),
      items: [
        _buildSlideshowImage(context,
            "assets/images/swinefarmingimages/animalwelfare.jpg",
            "Selecting the Right Breed",
            "Choose hardy breeds like Landrace or native pigs."),
        _buildSlideshowImage(context, "assets/images/swinefarmingimages/pigbreeding.jpg",
            "Breeding Management", "Plan mating for strong piglets."),
        _buildSlideshowImage(context,
            "assets/images/swinefarmingimages/keeping-piglets-warm.jpg",
            "Caring for Piglets",
            "Keep them warm and fed!"),
        _buildSlideshowImage(context, "assets/images/swinefarmingimages/pig1.jpg",
            "Maintain Swine", "Daily care keeps pigs healthy."),
        _buildSlideshowImage(context, "assets/images/swinefarmingimages/native-pigs.jpg",
            "Native Pigs", "Great for small farms!"),
        _buildSlideshowImage(context, "assets/images/swinefarmingimages/pig3.jpg",
            "Pig Progress", "Track growth for profit."),
      ],
    );
  }

  Widget _buildSlideshowImage(BuildContext context, String imagePath, String label, String subtitle) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(imagePath, fit: BoxFit.cover),
            Positioned(
              bottom: 15,
              left: 15,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      backgroundColor: isDarkMode ? Colors.black54 : Colors.black54,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white70,
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

  Widget _buildSectionHeader(BuildContext context, String title) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Row(
      children: [
        Icon(
          Icons.agriculture,
          color: isDarkMode ? Colors.white : const Color(0xffec7c86),
          size: 30,
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : const Color(0xffec7c86),
          ),
        ),
      ],
    );
  }

  Widget _buildImageContainer(BuildContext context, String imagePath) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          imagePath,
          height: 180,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildDescriptionText(BuildContext context, String text) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 18,
          color: isDarkMode ? Colors.white70 : Colors.black87,
          height: 1.5,
        ),
      ),
    );
  }

  List<Widget> _buildGuideItems(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return [
      _buildGuideItem(context,
        title: "Provide Clean Water Daily",
        description: "Pigs need clean water all day:\n\n"
            "• Why? Dirty water spreads sickness.\n"
            "• How? Use nipple drinkers (1 per 10 pigs).\n"
            "• Tips: Test water monthly—pH 6.5-8.5 is best. Flush pipes weekly to stop slime.\n"
            "• Bonus: Add a water tank for dry days.\n\n"
            "Success: A Pampanga farm boosted pig weight by 15% with clean water!",
        imagePath: "assets/images/swinefarmingimages/cleanwater.jpg",
        icon: Icons.water_drop,
      ),
      _buildGuideItem(context,
        title: "Maintain Proper Hygiene",
        description: "Cleanliness stops diseases:\n\n"
            "• Daily: Shovel out manure, scrape leftover feed.\n"
            "• Weekly: Spray pens with disinfectant (1:200 potassium peroxymonosulfate).\n"
            "• Monthly: Power wash floors and walls.\n"
            "• Extras: Footbaths at gates (use lime), boot dips for workers.\n\n"
            "Success: A Batangas farm stopped cholera with footbaths and no visitors!",
        imagePath: "assets/images/swinefarmingimages/hygiene.jpg",
        icon: Icons.cleaning_services,
      ),
      _buildGuideItem(context,
        title: "Proper Housing & Biosecurity",
        description: "Pigs need well-ventilated housing,"
            " adequate space, and proper drainage. Biosecurity measures, \n"
            " like limiting visitors, using footbaths, quarantining new pigs,\n"
            "and regular disinfection, help prevent disease outbreaks.\n",
        imagePath: "assets/images/swinefarmingimages/ProperHousing.jpg",
        icon: Icons.house,
      ),
      _buildGuideItem(context,
        title: "Breeding & Reproduction",
        description: "Monitor sows for estrus, maintain healthy boars, and consider "
            " artificial insemination for improved genetics. Proper care during  \n"
            " pregnancy ensures healthy piglets.\n",
        imagePath: "assets/images/swinefarmingimages/BreedingReproduction.jpeg",
        icon: Icons.type_specimen,
      ),
      _buildGuideItem(context,
        title: "Waste Management",
        description: "Properly manage manure and wastewater to maintain "
            " hygiene and protect the environment. Composting or  \n"
            " using wastewater treatment systems can be effective.\n",
        imagePath: "assets/images/swinefarmingimages/WasteManagement.jpg",
        icon: Icons.transfer_within_a_station,
      ),
      _buildGuideItem(context,
        title: "Ensure a Balanced Diet",
        description: "Feed right for fat pigs:\n\n"
            "• Growers (20-50kg)**: 16-18% protein, 3,200 kcal/kg—corn + soybean mix.\n"
            "• Finishers (50-100kg)**: 14-16% protein, 3,100 kcal/kg—less protein, more carbs.\n"
            "• Sows: Add 1% calcium (crushed shells) when nursing.\n"
            "• Rules: Store feed in dry bins, use oldest first, no banned drugs.\n"
            "• Warning: Swill must be cooked (90°C, 1 hour) to kill germs.\n\n"
            "Tip: Mix your own feed to save cash!",
        imagePath: "assets/images/swinefarmingimages/pigfood.jpg",
        icon: Icons.fastfood,
      ),
      _buildGuideItem(context,
        title: "Monitor for Diseases",
        description: "Catch problems fast:\n\n"
            "• Red Flags: Blue ears (ASF?), bloody poop, fever over 40°C, sudden deaths.\n"
            "• Prevention: Vaccinate for hog cholera (6 months), deworm with ivermectin (3 months).\n"
            "• Quarantine: New pigs stay separate for 30 days—watch for coughs or limps.\n"
            "• Tools: Use a thermometer, keep a logbook.\n\n"
            "Success: A Cebu co-op tracks shots online and cut losses by 50%!",
        imagePath: "assets/images/swinefarmingimages/disease_monitoring.jpg",
        icon: Icons.health_and_safety
      ),
      _buildGuideItem(context,
        title: "Marketing & Financial Planning",
        description: "Research the pork market, build relationships with buyers, and  "
            " track expenses to optimize profitability. Efficient planning ensures  \n"
            " long-term success.\n",
        imagePath: "assets/images/swinefarmingimages/MarketingFinancial.jpg",
        icon: Icons.next_plan,
      ),
    ];
  }

  Widget _buildGuideItem(
      BuildContext context, {
        required String title,
        required String description,
        required String imagePath,
        required IconData icon,
      }) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 12),
      color: isDarkMode ? Colors.grey[800] : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Scaffold(
                appBar: AppBar(
                  backgroundColor: ArgieColors.primary,
                  title: Text(title,
                      style: GoogleFonts.poppins(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
                backgroundColor: isDarkMode ? Colors.grey[850] : Colors.white,
                body: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(imagePath,
                              width: double.infinity,
                              height: 220,
                              fit: BoxFit.cover),
                        ),
                        const SizedBox(height: 16),
                        Text(description,
                            style: GoogleFonts.poppins(
                                fontSize: 18,
                                color: isDarkMode ? Colors.white70 : Colors.black87,
                                height: 1.5)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(20),
        splashColor: ArgieColors.primary.withValues(alpha: 0.3),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(imagePath,
                    width: 90, height: 90, fit: BoxFit.cover),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(icon, color: isDarkMode ? Colors.white : const Color(0xffec7c86), size: 24),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            title,
                            style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: isDarkMode ? Colors.white : Colors.black87),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                          fontSize: 16, color: isDarkMode ? Colors.white70 : Colors.black54, height: 1.5),
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

  Widget _buildStackedContent(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Stack(
      alignment: Alignment.center,
      children: [
        _buildImageContainer(context, "assets/images/swinefarmingimages/RightBreed.jpg"),
        Positioned(
          bottom: 25,
          child: ElevatedButton(
            onPressed: () => _launchURL(
                "https://philjournalsci.dost.gov.ph/images/pdf/pjs_pdf/vol151no5/genetic_diversity_of_Phil_native_pig_from_Quezon_and_Marinduque_.pdf"),
            style: ElevatedButton.styleFrom(
              backgroundColor: ArgieColors.secondary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
            child: Text(
              "Learn More About Pigs",
              style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickTipsToggle(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () => setState(() => _showQuickTips = !_showQuickTips),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[700] : const Color(0xffec7c86).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Quick Tips for Farmers",
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : const Color(0xffec7c86)),
            ),
            Icon(_showQuickTips ? Icons.expand_less : Icons.expand_more,
                color: isDarkMode ? Colors.white : const Color(0xffec7c86)),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickTipsSection(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildQuickTip(context, "Start Small",
              "Begin with 5-10 pigs to learn the ropes before scaling up."),
          _buildQuickTip(context, "Check Daily",
              "Walk your pens every morning—happy pigs mean good profits!"),
          _buildQuickTip(context, "Save Rainwater",
              "Collect rain in barrels for cheap, clean water."),
          _buildQuickTip(context,
              "Sell Smart", "Time sales for holidays when pork prices spike."),
        ],
      ),
    );
  }

  Widget _buildQuickTip(BuildContext context, String title, String tip) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: Color(0xffec7c86), size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black87)),
                Text(tip,
                    style: GoogleFonts.poppins(
                        fontSize: 14, color: isDarkMode ? Colors.white70 : Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLinksSection(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.link, color: isDarkMode ? Colors.white : const Color(0xffec7c86), size: 24),
            const SizedBox(width: 10),
            Text(
              "For More Info:",
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black87),
            ),
          ],
        ),
        const SizedBox(height: 10),
        _buildLink(context,
          text: "Code of Good Animal Husbandry Practices for Swine",
          url:
          "https://pcsp.org.ph/wp-content/uploads/2019/06/Correct-final-draft-GAHP-for-Swine.pdf",
        ),
        const SizedBox(height: 10),
        _buildLink(context,
          text: "Swine Raising Tips and Best Practices",
          url:
          "https://cagayanvalley.da.gov.ph/wp-content/uploads/2018/02/swine.pdf",
        ),
        _buildLink(context,
          text: "Essential Guide to Pig Farming",
          url:
          "https://www.bivatec.com/blog/the-guide-to-starting-a-profitable-pig-farm",
        ),
      ],
    );
  }

  Widget _buildLink(BuildContext context, {required String text, required String url}) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () => _launchURL(url),
      child: Row(
        children: [
          Icon(Icons.arrow_forward, color: isDarkMode ? Colors.white : const Color(0xffec7c86), size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: isDarkMode ? Colors.white : const Color(0xffec7c86),
                  decoration: TextDecoration.underline),
            ),
          ),
        ],
      ),
    );
  }
}