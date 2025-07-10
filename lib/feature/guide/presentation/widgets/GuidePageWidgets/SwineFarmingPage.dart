import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:iconsax/iconsax.dart';
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
  int _currentCarouselIndex = 0;
  bool _showSearchBar = false;
  final TextEditingController _searchController = TextEditingController();
  List<String> _searchResults = [];

  final List<Map<String, String>> _guideTopics = [
    {
      "title": "Provide Clean Water Daily",
      "description": "Pigs need clean water all day:\n\n"
          "• Why? Dirty water spreads sickness.\n"
          "• How? Use nipple drinkers (1 per 10 pigs).\n"
          "• Tips: Test water monthly—pH 6.5-8.5 is best. Flush pipes weekly to stop slime.\n"
          "• Bonus: Add a water tank for dry days.\n\n"
          "Success: A Pampanga farm boosted pig weight by 15% with clean water!",
      "imagePath": "assets/images/swinefarmingimages/cleanwater.jpg",
      "category": "basic",
    },
    {
      "title": "Maintain Proper Hygiene",
      "description": "Cleanliness stops diseases:\n\n"
          "• Daily: Shovel out manure, scrape leftover feed.\n"
          "• Weekly: Spray pens with disinfectant (1:200 potassium peroxymonosulfate).\n"
          "• Monthly: Power wash floors and walls.\n"
          "• Extras: Footbaths at gates (use lime), boot dips for workers.\n\n"
          "Success: A Batangas farm stopped cholera with footbaths and no visitors!",
      "imagePath": "assets/images/swinefarmingimages/hygiene.jpg",
      "category": "basic",
    },
    {
      "title": "Proper Housing & Biosecurity",
      "description": "Give pigs the right home:\n\n"
          "• Space: Each adult pig needs 1.5-2 square meters to move and rest.\n"
          "• Ventilation: Good air flow keeps pigs from getting sick in hot weather.\n"
          "• Drainage: Floors should slope 3-5% so waste and water flow out easily.\n"
          "• Safety: Keep other animals away with good fencing.\n\n"
          "Remember: No visitors without footbaths! They can bring germs from other farms.",
      "imagePath": "assets/images/swinefarmingimages/ProperHousing.jpg",
      "category": "basic",
    },
    {
      "title": "Breeding & Reproduction",
      "description": "Make more pigs successfully:\n\n"
          "• Heat Signs: Red vulva, standing still when pushed, restlessness (18-24 hours).\n"
          "• Best Time: Breed 12-18 hours after first seeing heat signs.\n"
          "• Pregnancy: Lasts 114 days (3 months, 3 weeks, 3 days).\n"
          "• Preparation: Give separate pen with extra bedding 3-5 days before birth.\n\n"
          "Healthy sows should have 8-12 piglets. Feed them extra during nursing!",
      "imagePath": "assets/images/swinefarmingimages/BreedingReproduction.jpeg",
      "category": "advanced",
    },
    {
      "title": "Waste Management",
      "description": "Turn pig waste into value:\n\n"
          "• Composting: Mix manure with rice husks (3:1 ratio), turn weekly for 45 days.\n"
          "• Biogas: Small digesters can make cooking gas from manure.\n"
          "• Fertilizer: Diluted pig waste water (1:4 with clean water) for crops.\n"
          "• Never: Dump waste in rivers or streams!\n\n"
          "Success: Farmer in Laguna saves ₱2,000/month using manure as fertilizer.",
      "imagePath": "assets/images/swinefarmingimages/WasteManagement.jpg",
      "category": "advanced",
    },
    {
      "title": "Balanced Pig Diet",
      "description": "Feed right for fat pigs:\n\n"
          "• Growers (20-50kg): 16-18% protein, 3,200 kcal/kg—corn + soybean mix.\n"
          "• Finishers (50-100kg): 14-16% protein, 3,100 kcal/kg—less protein, more carbs.\n"
          "• Sows: Add 1% calcium (crushed shells) when nursing.\n"
          "• Rules: Store feed in dry bins, use oldest first, no banned drugs.\n"
          "• Warning: Swill must be cooked (90°C, 1 hour) to kill germs.\n\n"
          "Tip: Mix your own feed to save cash!",
      "imagePath": "assets/images/swinefarmingimages/pigfood.jpg",
      "category": "basic",
    },
    {
      "title": "Disease Prevention",
      "description": "Catch problems fast:\n\n"
          "• Red Flags: Blue ears (ASF?), bloody poop, fever over 40°C, sudden deaths.\n"
          "• Prevention: Vaccinate for hog cholera (6 months), deworm with ivermectin (3 months).\n"
          "• Quarantine: New pigs stay separate for 30 days—watch for coughs or limps.\n"
          "• Tools: Use a thermometer, keep a logbook.\n\n"
          "Success: A Cebu co-op tracks shots online and cut losses by 50%!",
      "imagePath": "assets/images/swinefarmingimages/disease_monitoring.jpg",
      "category": "basic",
    },
    {
      "title": "Marketing Your Pork",
      "description": "Sell your pigs for best profit:\n\n"
          "• Timing: Pigs reach market weight (70-90kg) in 5-6 months with good care.\n"
          "• Direct Sales: Sell to local butchers for higher prices than middlemen.\n"
          "• Group Selling: Join with other small farmers to sell in bulk.\n"
          "• Planning: Target fiestas and holidays when pork demand is high.\n\n"
          "Success: Group of Pampanga farmers increased profit by 30% selling directly to restaurants!",
      "imagePath": "assets/images/swinefarmingimages/MarketingFinancial.jpg",
      "category": "advanced",
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _searchGuides(String query) {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    setState(() {
      _searchResults = _guideTopics
          .where((topic) =>
      topic["title"]!.toLowerCase().contains(query.toLowerCase()) ||
          topic["description"]!.toLowerCase().contains(query.toLowerCase()))
          .map((topic) => topic["title"]!)
          .toList();
    });
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Could not launch $url',
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.grey[850] : const Color(0xFFF5F5F0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEC7C86),
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_circle_left, color: Colors.white),
          onPressed: () => context.go('/guide'),
        ),
        title: _showSearchBar
            ? TextField(
          controller: _searchController,
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: "Search farming tips...",
            hintStyle: TextStyle(color: Colors.white70),
            border: InputBorder.none,
          ),
          onChanged: _searchGuides,
        )
            : Text(
          "Swine Farming Guide",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline, color: Colors.white),
            onPressed: () {
              _showFarmersTips(context);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildSlideshowHeader(context),
              const SizedBox(height: 20),
              _buildSectionHeader(context, "Successful Pig Farming Basics"),
              _buildImageContainer(context, "assets/images/swinefarmingimages/HusbandryPractices.jpg"),
              _buildDescriptionText(context,
                "Simple steps for successful pig farming:\n\n"
                    "• Farm Location: Keep at least 1 km from town to avoid smell complaints.\n"
                    "• Keep Pigs Safe: Strong fences keep out stray dogs and wild animals.\n"
                    "• Manage Waste: Use compost pits—NEVER dump in rivers! Make fertilizer.\n"
                    "• Give Space: Allow 1.5-2 square meters per grown pig.\n"
                    "• Provide Shade: Pigs need cool areas on hot days.\n\n"
                    "Success Story: Mang Pedro from Bulacan cut disease problems by 70% with good fencing and waste management!",
              ),
              const Divider(color: Colors.grey, height: 30),

              // Basic Techniques Section
              _buildCategorySectionHeader("Basic Pig Raising Techniques", Icons.menu_book),
              ..._buildGuideItems(context, "basic"),

              const SizedBox(height: 20),

              // Advanced Techniques Section
              _buildCategorySectionHeader("Advanced Farming Methods", Icons.psychology),
              ..._buildGuideItems(context, "advanced"),

              const Divider(color: Colors.grey, height: 30),

              _buildSeasonalCareSection(context),
              const SizedBox(height: 20),

              _buildStackedContent(context),
              const SizedBox(height: 20),

              _buildQuickTipsToggle(context),
              if (_showQuickTips) _buildQuickTipsSection(context),

              const SizedBox(height: 30),
              _buildDiseaseAlertSection(context),
              const SizedBox(height: 20),

              _buildCommonProblemsSection(context),
              const SizedBox(height: 20),

              _buildLinksSection(context),
              const SizedBox(height: 30),
            ],
          ),
          if (_searchResults.isNotEmpty)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                color: isDarkMode ? Colors.grey[800] : Colors.white,
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(10),
                  itemCount: _searchResults.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.article, color: Color(0xFFEC7C86)),
                      title: Text(_searchResults[index]),
                      onTap: () {
                        // Find the guide item and open it
                        final guideItem = _guideTopics.firstWhere(
                                (topic) => topic["title"] == _searchResults[index]
                        );
                        Navigator.push(
                          context,
                          FadePageRoute(
                            builder: (context) => GuideDetailPage(
                              title: guideItem["title"]!,
                              imagePath: guideItem["imagePath"]!,
                              fullDescription: guideItem["description"]!,
                            ),
                          ),
                        );

                        setState(() {
                          _showSearchBar = false;
                          _searchController.clear();
                          _searchResults.clear();
                        });
                      },
                    );
                  },
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showOfflineGuidesDialog(context);
        },
        backgroundColor: const Color(0xFFEC7C86),
        child: const Icon(Icons.download, color: Colors.white),
      ),
    );
  }

  Widget _buildCategorySectionHeader(String title, IconData icon) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[800] : const Color(0xFFEC7C86).withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFEC7C86).withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: isDarkMode ? Colors.white : const Color(0xFFEC7C86),
            size: 22,
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : const Color(0xFFEC7C86),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiseaseAlertSection(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[700] : Colors.red[50],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.red, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.red,
                  size: 18
              ),
              const SizedBox(width: 10),
              Text(
                "African Swine Fever Alert",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            "ASF is currently active in some areas. Protect your pigs:",
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: isDarkMode ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          _buildDiseasePoint("NEVER feed kitchen waste/swill without cooking at 90°C for 1 hour"),
          _buildDiseasePoint("Maintain strict visitor policies - no visitors from other farms"),
          _buildDiseasePoint("Disinfect vehicles, boots, and equipment entering your farm"),
          _buildDiseasePoint("Report any sudden pig deaths to your local veterinarian immediately"),
          const SizedBox(height: 10),
          Center(
            child: ElevatedButton.icon(
              onPressed: () => _launchURL("https://www.bai.gov.ph/"),
              icon: const Icon(Icons.info, color: Colors.white),
              label: Text(
                "Learn More About ASF",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiseasePoint(String point) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red)),
          Expanded(
            child: Text(
              point,
              style: GoogleFonts.poppins(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSeasonalCareSection(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[700] : Colors.blue[50],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.blue, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.wb_sunny, color: Colors.orange, size: 24),
              const SizedBox(width: 10),
              Text(
                "Seasonal Pig Care",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            "Adjust your pig care based on current weather:",
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: isDarkMode ? Colors.white70 : Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          ExpansionTile(
            title: Text(
              "Hot Weather Care",
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            ),
            leading: Icon(Icons.thermostat, color: Colors.red),
            children: [
              _buildSeasonalTip("Provide extra water sources (at least 2 nipple drinkers per pen)"),
              _buildSeasonalTip("Install cooling sprinklers or wet the floor during peak heat"),
              _buildSeasonalTip("Feed during cooler hours (early morning and evening)"),
              _buildSeasonalTip("Ensure good ventilation and airflow in all pens"),
            ],
          ),
          ExpansionTile(
            title: Text(
              "Rainy Season Care",
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            ),
            leading: Icon(Icons.water_drop, color: Colors.blue),
            children: [
              _buildSeasonalTip("Check and repair leaky roofs to keep bedding dry"),
              _buildSeasonalTip("Improve drainage around pens to prevent flooding"),
              _buildSeasonalTip("Store extra feed in waterproof containers"),
              _buildSeasonalTip("Monitor for respiratory issues that increase in wet weather"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSeasonalTip(String tip) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Expanded(
            child: Text(
              tip,
              style: GoogleFonts.poppins(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommonProblemsSection(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[700] : Colors.amber[50],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.amber, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                  Icons.healing,
                  color: Colors.amber[800],
                  size: 18
              ),
              const SizedBox(width: 10),
              Text(
                "Common Problems & Solutions",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          _buildProblemSolution(
              "Diarrhea",
              "Temporary stop feeding, provide electrolytes in water. Clean pen thoroughly. Call vet if continues more than 24 hours."
          ),
          _buildProblemSolution(
              "Not Eating",
              "Check for fever. Ensure fresh feed and clean water. Look for signs of swelling, injury or pain. Immediate vet care needed."
          ),
          _buildProblemSolution(
              "Coughing/Breathing Problems",
              "Improve ventilation. Remove dusty bedding. Separate affected pig. Call vet - could be pneumonia or other serious condition."
          ),
          _buildProblemSolution(
              "Slow Growth",
              "Check for parasites. Improve feed quality. Deworm regularly. May need vitamin supplements. Check feed amount for age."
          ),
          const SizedBox(height: 10),
          Center(
            child: OutlinedButton.icon(
              onPressed: () => _showEmergencyContactsDialog(context),
              icon: const Icon(Icons.phone),
              label: Text(
                "Emergency Contacts",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                ),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.amber[800],
                side: BorderSide(color: Colors.amber[800]!),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showEmergencyContactsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Emergency Contacts",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildEmergencyContact("Email:", "pvoddn@gmail.com\n"),
            _buildEmergencyContact("Phone:", "+63 917 792 2480\n"),
            _buildEmergencyContact("Address:", "Provincial Government Center, Mankilam, Tagum City, Davao del Norte, Tagum City, Philippines"),
            _buildEmergencyContact("DAVAO Provincial Office", "Check your region"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyContact(String name, String phone) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          const Icon(Icons.phone, size: 20, color: Colors.red),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(phone, style: const TextStyle(color: Colors.blue)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProblemSolution(String problem, String solution) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.report_problem, size: 15, color: Colors.amber[800]),
              const SizedBox(width: 8),
              Text(
                problem,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 26),
            child: Text(
              solution,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: isDarkMode ? Colors.white70 : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showFarmersTips(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Quick Help for Pig Farmers",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHelpItem("Tap any card to see full details"),
            _buildHelpItem("Use search to find specific pig care topics"),
            _buildHelpItem("Download guides to read when offline"),
            _buildHelpItem("Watch for health issues daily to catch problems early"),
            _buildHelpItem("Keep pigs cool in hot weather and dry in rainy season"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK", style: TextStyle(color: Color(0xFFEC7C86))),
          )
        ],
      ),
    );
  }

  Widget _buildHelpItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Color(0xFFEC7C86), size: 20),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  void _showOfflineGuidesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Download Swine Guides",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Download guides to read when you don't have internet:"),
            const SizedBox(height: 15),
            _buildDownloadItem("Pig Feeding Manual (2 MB)", true),
            _buildDownloadItem("Disease Prevention Guide (3 MB)", false),
            _buildDownloadItem("Housing & Pen Setup (4 MB)", false),
            _buildDownloadItem("Complete Swine Farming Manual (10 MB)", false),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Downloading guides..."),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEC7C86),
            ),
            child: const Text("Download Selected"),
          ),
        ],
      ),
    );
  }

  Widget _buildDownloadItem(String title, bool downloaded) {
    return CheckboxListTile(
      title: Text(title),
      subtitle: Text(downloaded ? "Already downloaded" : "Not downloaded"),
      value: downloaded,
      onChanged: (value) {
        // This would be implemented with actual download functionality
      },
      activeColor: const Color(0xFFEC7C86),
    );
  }

  Widget _buildSlideshowHeader(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 240,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.85,
            autoPlayInterval: const Duration(seconds: 4),
            onPageChanged: (index, reason) {
              setState(() {
                _currentCarouselIndex = index;
              });
            },
          ),
          items: [
            _buildSlideshowImage(context,
                "assets/images/swinefarmingimages/animalwelfare.jpg",
                "Selecting the Right Breed",
                "Native pigs cost less & resist disease better"),
            _buildSlideshowImage(context, "assets/images/swinefarmingimages/pigbreeding.jpg",
                "Breeding Management", "Good boars = more piglets & faster profit"),
            _buildSlideshowImage(context,
                "assets/images/swinefarmingimages/keeping-piglets-warm.jpg",
                "Caring for Piglets",
                "Warm piglets grow 30% faster!"),
            _buildSlideshowImage(context, "assets/images/swinefarmingimages/pig1.jpg",
                "Daily Swine Care", "Check pigs every morning & save money on vets"),
            _buildSlideshowImage(context, "assets/images/swinefarmingimages/native-pigs.jpg",
                "Native Pigs", "Need less feeds, perfect for small farms"),
            _buildSlideshowImage(context, "assets/images/swinefarmingimages/pig3.jpg",
                "Farm Record-Keeping", "Track costs & weights to earn more"),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(6, (index) {
            return Container(
              width: 10,
              height: 10,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentCarouselIndex == index
                    ? const Color(0xFFEC7C86)
                    : Colors.grey,
              ),
            );
          }),
        ),
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
        const SizedBox(width: 10),
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : const Color(0xFFEC7C86),
          ),
        ),
      ],
    );
  }

  Widget _buildImageContainer(BuildContext context, String imagePath) {
    //final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
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

  List<Widget> _buildGuideItems(BuildContext context, String category) {
    //final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return _guideTopics
        .where((topic) => topic["category"] == category)
        .map((topic) => _buildGuideItem(
      context: context,
      title: topic["title"]!,
      description: topic["description"]!,
      imagePath: topic["imagePath"]!,
      icon: Icons.article,
      key: ValueKey(topic["title"]),
    ))
        .toList();
  }

  Widget _buildGuideItem({
    required BuildContext context,
    required String title,
    required String description,
    required String imagePath,
    required IconData icon,
    Key? key,
  }) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          FadePageRoute(
            builder: (context) => GuideDetailPage(
              title: title,
              imagePath: imagePath,
              fullDescription: description,
            ),
          ),
        );
      },
      child: Card(
        key: key,
        elevation: 5,
        margin: const EdgeInsets.symmetric(vertical: 12),
        color: isDarkMode ? Colors.grey[800] : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          splashColor: ArgieColors.primary.withValues(alpha: 0.3),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: title, // Hero for smooth image transition
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      imagePath,
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(icon, color: isDarkMode ? Colors.white : const Color(0xFFEC7C86), size: 24),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              title,
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: isDarkMode ? Colors.white : Colors.black87,
                              ),
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
                          fontSize: 16,
                          color: isDarkMode ? Colors.white70 : Colors.black54,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStackedContent(BuildContext context) {
    // final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Stack(
      alignment: Alignment.center,
      children: [
        _buildImageContainer(context, "assets/images/swinefarmingimages/RightBreed.jpg"),
        Positioned(
          bottom: 25,
          child: ElevatedButton(
            onPressed: () => _launchURL(
                "https://philjournalsci.dost.gov.ph/"),
            style: ElevatedButton.styleFrom(
              backgroundColor: ArgieColors.secondary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
            child: Text(
              "Learn More About Pigs",
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
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
          color: isDarkMode ? Colors.grey[700] : const Color(0xFFEC7C86).withValues(alpha: 0.1),
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
                color: isDarkMode ? Colors.white : const Color(0xFFEC7C86),
              ),
            ),
            Icon(_showQuickTips ? Icons.expand_less : Icons.expand_more,
                color: isDarkMode ? Colors.white : const Color(0xFFEC7C86)),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickTipsSection(BuildContext context) {
    // final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
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
          _buildQuickTip(context, "Sell Smart",
              "Time sales for holidays when pork prices spike."),
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
          const Icon(Icons.check_circle, color: Color(0xFFEC7C86), size: 20),
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
            Icon(Icons.link, color: isDarkMode ? Colors.white : const Color(0xFFEC7C86), size: 24),
            const SizedBox(width: 10),
            Text(
              "For More Info:",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        _buildLink(context,
          text: "Code of Good Animal Husbandry Practices for Swine",
          url: "https://pcsp.org.ph/wp-content/uploads/2019/06/Correct-final-draft-GAHP-for-Swine.pdf",
        ),
        const SizedBox(height: 10),
        _buildLink(context,
          text: "Swine Raising Tips and Best Practices",
          url: "https://cagayanvalley.da.gov.ph/wp-content/uploads/2018/02/swine.pdf",
        ),
        _buildLink(context,
          text: "Essential Guide to Pig Farming",
          url: "https://www.bivatec.com/blog/the-guide-to-starting-a-profitable-pig-farm",
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
          Icon(Icons.arrow_forward, color: isDarkMode ? Colors.white : const Color(0xFFEC7C86), size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: isDarkMode ? Colors.white : const Color(0xFFEC7C86),
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
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

class GuideDetailPage extends StatelessWidget {
  final String title;
  final String imagePath;
  final String fullDescription;

  const GuideDetailPage({
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
        backgroundColor: const Color(0xFFEC7C86),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: () {
              Share.share(
                'Check out this pig farming tip: $title\n\n$fullDescription\n\nFrom: SwineGuide App',
              );
            },
          ),
        ],
      ),
      backgroundColor: isDarkMode ? Colors.grey[850] : Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: title,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    imagePath,
                    width: double.infinity,
                    height: 220,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                fullDescription,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: isDarkMode ? Colors.white70 : Colors.black87,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 25),
              const Divider(),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: const Color(0xFFEC7C86),
                  child: Text("DA", style: TextStyle(color: Colors.white)),
                ),
                title: Text(
                  "Expert Advice",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "From Department of Agriculture Specialist",
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  "Always start with good quality animals that fit your budget. For beginners, we recommend starting with 3-5 weanlings rather than jumping into breeding right away. This gives you time to learn basic care before taking on more responsibilities.",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: isDarkMode ? Colors.white70 : Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.grey[700] : Colors.blue[50],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Local Resources",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.phone, size: 20),
                        const SizedBox(width: 10),
                        Text(
                          "Phone: +63 917 792 2480\n",
                          style: GoogleFonts.poppins(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 20),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "Nearest Livestock Office: Check your provincial agricultural office",
                            style: GoogleFonts.poppins(fontSize: 16),
                          ),
                        ),
                      ],
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
}