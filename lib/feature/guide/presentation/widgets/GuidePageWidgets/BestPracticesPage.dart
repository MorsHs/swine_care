import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:swine_care/colors/ArgieColors.dart';
import 'package:swine_care/colors/ArgieSizes.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

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

class BestPracticesPage extends StatefulWidget {
  const BestPracticesPage({super.key});

  @override
  State<BestPracticesPage> createState() => _BestPracticesPageState();
}

class _BestPracticesPageState extends State<BestPracticesPage> {
  bool _showFilters = false;
  String _selectedFilter = "All";
  final List<String> _filters = ["All", "Starting", "Managing", "Advanced"];

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch $url')),
        );
      }
    }
  }

  void _shareContent(String title, String content) {
    Share.share(
      'SWINE FARMING TIP: $title\n\n$content\n\nFrom: SwineGuide App',
    );
  }


  Widget _buildExpertItem(String name, String specialty, String contact) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: ArgieColors.primary.withValues(alpha: 0.2),
            child: Icon(Icons.person, color: ArgieColors.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(specialty, style: const TextStyle(fontSize: 14)),
                Text(contact, style: TextStyle(color: ArgieColors.primary)),
              ],
            ),
          ),
        ],
      ),
    );
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
          "Best Swine Practices",
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.white),
            onPressed: () {
              setState(() {
                _showFilters = !_showFilters;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          if (_showFilters)
            Container(
              color: isDarkMode ? ArgieColors.darkAccent : Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: _filters.map((filter) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ChoiceChip(
                        label: Text(filter),
                        selected: _selectedFilter == filter,
                        onSelected: (selected) {
                          setState(() {
                            _selectedFilter = filter;
                          });
                        },
                        backgroundColor: isDarkMode ? ArgieColors.dark : Colors.grey[200],
                        selectedColor: ArgieColors.primary.withValues(alpha: 0.7),
                        labelStyle: TextStyle(
                          color: _selectedFilter == filter ? Colors.white : isDarkMode ? Colors.white70 : Colors.black87,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(ArgieSizes.paddingDefault),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_selectedFilter == "All" || _selectedFilter == "Starting") ...[
                    _buildSectionTitle(context, "Starting Your Farm"),
                    _buildPracticeCard(
                      context: context,
                      title: "1. Choose the Right Location",
                      imagePath: "assets/images/bestpracticesimages/RightLocation.jpg",
                      content: "• Pick high, dry land with good drainage\n"
                          "• Stay 1 km from towns to avoid complaints\n"
                          "• Make sure there's clean water all year\n"
                          "• Success story: Mang Juan's farm in Bulacan has zero disease in 2 years by picking a good spot.",
                      tip: "Tip: Visit the area after heavy rain to check for flooding.",
                      fullDescription: _locationDescription,
                      key: const ValueKey("card_location"),
                    ),
                    _buildPracticeCard(
                      context: context,
                      title: "2. Select Healthy Breeds",
                      imagePath: "assets/images/bestpracticesimages/HealthyBreeds.jpg",
                      content: "• Landrace: Good mothers (12-14 piglets)\n"
                          "• Duroc: Grows fast, tasty meat\n"
                          "• Native pigs: Need less feed, resist disease\n"
                          "• Always check for bright eyes and clean skin.",
                      tip: "Tip: Start with 3-5 weanlings before trying breeding.",
                      fullDescription: _breedsDescription,
                      key: const ValueKey("card_breeds"),
                    ),
                    _buildPracticeCard(
                      context: context,
                      title: "3. Build Proper Pens",
                      imagePath:
                      "assets/images/bestpracticesimages/ProperInfrastructure.jpg",
                      content: "• Adult pig needs 4m² space to move\n"
                          "• Concrete floors slope 2-3% for drainage\n"
                          "• Put footbaths at ALL entrances\n"
                          "• Half-roof provides shade and sun options.",
                      tip: "Tip: Use cheap local materials but never skimp on pen size.",
                      fullDescription: _pensDescription,
                      key: const ValueKey("card_pens"),
                    ),
                  ],

                  if (_selectedFilter == "All" || _selectedFilter == "Managing") ...[
                    const SizedBox(height: 20),
                    _buildSectionTitle(context, "Managing Your Farm"),
                    _buildPracticeCard(
                      context: context,
                      title: "1. Daily Feeding Schedule",
                      imagePath: "assets/images/bestpracticesimages/FeedingRoutine.jpg",
                      content: "• Small pigs (up to 20kg): Feed 3 times daily\n"
                          "• Growing pigs (20-50kg): 16-18% protein twice daily\n"
                          "• Fattening pigs (50-100kg): 14-16% protein once daily\n"
                          "• Always provide clean, fresh water 24/7.",
                      tip: "Tip: Use separate feeders for each pig to control portions.",
                      fullDescription: _feedingDescription,
                      key: const ValueKey("card_feeding"),
                    ),
                    _buildPracticeCard(
                      context: context,
                      title: "2. Prevent Disease Outbreaks",
                      imagePath:
                      "assets/images/bestpracticesimages/DiseasePrevention.jpg",
                      content: "• Vaccinate on schedule (mark calendar!)\n"
                          "• Keep new pigs separate for 30 days\n"
                          "• Watch for: no eating, fever, blue ears (ASF!)\n"
                          "• Call vet immediately if pig looks sick.",
                      tip: "Tip: Take photos of sick pigs to show vet if you can't bring them in.",
                      fullDescription: _diseaseDescription,
                      key: const ValueKey("card_disease"),
                    ),
                    _buildPracticeCard(
                      context: context,
                      title: "3. Keep It Clean",
                      imagePath:
                      "assets/images/bestpracticesimages/HygieneSanitation.jpg",
                      content: "• Morning: Remove ALL manure and wet bedding\n"
                          "• Weekly: Scrub walls and floors with soap\n"
                          "• Monthly: Spray disinfectant everywhere\n"
                          "• Clean pens = healthy pigs = more profit!",
                      tip: "Tip: Mix 1 cup bleach with 5 gallons water for cheap disinfectant.",
                      fullDescription: _cleanDescription,
                      key: const ValueKey("card_clean"),
                    ),
                    _buildPracticeCard(
                      context: context,
                      title: "4. Track Growth",
                      imagePath:
                      "assets/images/bestpracticesimages/MonitoringGrowth.jpg",
                      content: "• Weigh pigs monthly (use bathroom scale)\n"
                          "• Good growth: 0.5-0.8 kg per day\n"
                          "• Keep notebook for each pig's weight\n"
                          "• Slow growth means health problems.",
                      tip: "Tip: Mark pigs with different colored ear tags for easy tracking.",
                      fullDescription: _growthDescription,
                      key: const ValueKey("card_growth"),
                    ),
                  ],

                  if (_selectedFilter == "All" || _selectedFilter == "Advanced") ...[
                    const SizedBox(height: 20),
                    _buildSectionTitle(context, "Advanced Techniques"),
                    _buildPracticeCard(
                      context: context,
                      title: "1. Breeding Management",
                      imagePath: "assets/images/bestpracticesimages/DiseasePrevention.jpg", // Use existing image as fallback
                      content: "• Detect heat signs: red vulva, standing still\n"
                          "• Breed sows 12-18 hours after heat starts\n"
                          "• Keep breeding records with exact dates\n"
                          "• Pregnant sows need special feed with more calcium.",
                      tip: "Tip: Don't breed underweight sows - they need to be healthy first.",
                      fullDescription: _breedingDescription,
                      key: const ValueKey("card_breeding"),
                    ),
                    _buildPracticeCard(
                      context: context,
                      title: "2. Farm Waste Management",
                      imagePath: "assets/images/bestpracticesimages/HygieneSanitation.jpg", // Use existing image as fallback
                      content: "• Turn manure into fertilizer using composting\n"
                          "• Build biogas digester for cooking gas\n"
                          "• Separate liquid waste for crop irrigation\n"
                          "• Success story: Farm in Laguna saves ₱2,000/month on fertilizer costs.",
                      tip: "Tip: Cover manure piles with plastic to speed up composting.",
                      fullDescription: _wasteDescription,
                      key: const ValueKey("card_waste"),
                    ),
                  ],

                  const SizedBox(height: 20),
                  _buildTipsSection(context),
                  _buildHealthChecksSection(context),
                  _buildLinksSection(context),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showHelpDialog(context);
        },
        backgroundColor: const Color(0xff6da4ed),
        label: const Text("Get Help"),
        icon: const Icon(Icons.support),
      ),
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Need Help?",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHelpOption(
              "Call Swine Expert",
              "Get advice from professionals",
              Icons.call,
                  () {
                Navigator.pop(context);
                launchUrl(Uri.parse("tel:89202200"));
              },
            ),
            const Divider(),
            _buildHelpOption(
              "Emergency Guide",
              "What to do if pigs get sick",
              Icons.medical_services,
                  () {
                Navigator.pop(context);
                // Would navigate to emergency guide
              },
            ),
            const Divider(),
            _buildHelpOption(
              "Find Supplies Nearby",
              "Feeds, medicine, and equipment",
              Icons.shopping_cart,
                  () {
                Navigator.pop(context);
                // Would navigate to suppliers map
              },
            ),
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

  Widget _buildHelpOption(String title, String subtitle, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: ArgieColors.primary.withValues(alpha: 0.2),
        child: Icon(icon, color: ArgieColors.primary),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: onTap,
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: EdgeInsets.only(bottom: ArgieSizes.spaceBtwItems),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        color: isDarkMode ? ArgieColors.darkAccent.withValues(alpha: 0.6) : ArgieColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: isDarkMode ? ArgieColors.primary.withValues(alpha: 0.3) : ArgieColors.primary.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            title.contains("Starting") ? Iconsax.home :
            title.contains("Managing") ? Iconsax.task_square : Iconsax.chart,
            color: ArgieColors.primary,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? ArgieColors.textthird : ArgieColors.textBold,
            ),
          ),
        ],
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
              Stack(
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
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: ArgieColors.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Tap for Details",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
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
                  IconButton(
                    icon: Icon(Icons.share, color: ArgieColors.primary),
                    onPressed: () => _shareContent(title, content),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHealthChecksSection(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: isDarkMode ? ArgieColors.darkAccent : const Color(0xFFE3F2FD),
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: Padding(
        padding: EdgeInsets.all(ArgieSizes.paddingDefault),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.health_and_safety, color: Colors.blue, size: 24),
                SizedBox(width: ArgieSizes.spaceBtwItems),
                Text(
                  "Daily Health Checks",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? ArgieColors.textthird : ArgieColors.textBold,
                  ),
                ),
              ],
            ),
            SizedBox(height: ArgieSizes.spaceBtwItems),
            _buildHealthCheckItem(context, "Appetite", "Pigs should eat normally, no leftovers"),
            _buildHealthCheckItem(context, "Activity", "Pigs should stand up and move when you approach"),
            _buildHealthCheckItem(context, "Breathing", "Watch for coughing or heavy breathing"),
            _buildHealthCheckItem(context, "Skin", "Look for rashes, wounds, or blue/purple spots"),
            _buildHealthCheckItem(context, "Stool", "Should be firm, not watery or bloody"),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.warning_amber, color: Colors.red),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Call veterinarian immediately if you see multiple symptoms!",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
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

  Widget _buildHealthCheckItem(BuildContext context, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: Colors.blue, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                ),
                Text(
                  description,
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
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
            Row(
              children: [
                Icon(Icons.lightbulb_outline, color: Colors.orange, size: 24),
                SizedBox(width: ArgieSizes.spaceBtwItems),
                Text(
                  "Quick Tips for Success",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? ArgieColors.textthird : ArgieColors.textBold,
                  ),
                ),
              ],
            ),
            SizedBox(height: ArgieSizes.spaceBtwItems),
            _buildTipItem(context, Icons.check_circle, "Start small, grow steady - begin with 3-5 pigs"),
            _buildTipItem(context, Icons.check_circle, "Train your family members to help with daily care"),
            _buildTipItem(context, Icons.check_circle, "Keep a simple notebook for costs and pig weights"),
            _buildTipItem(context, Icons.check_circle, "Join local farmers' group to share knowledge"),
            _buildTipItem(context, Icons.check_circle, "Save the best females for breeding if you want to expand"),
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
                "Pig Farming in the Philippines: Complete Guide",
                "https://www.agrifarming.in/pig-farming-in-the-philippines-how-to-start#"),
            _buildLinkItem(
                context,
                "Making Money with Pigs: Business Tips",
                "https://filipinobusinesshub.com/piggery-business-in-the-philippines-2023/"),
            _buildLinkItem(
                context,
                "Department of Agriculture Swine Programs",
                "https://www.da.gov.ph/programs-and-activities/"),
            _buildLinkItem(
                context,
                "Preventing ASF on Your Farm",
                "https://www.bai.gov.ph/"),
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
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Hero(
              tag: title,
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.7),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: _buildFormattedDescription(context, fullDescription),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormattedDescription(BuildContext context, String description) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final sections = description.split('\n\n');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: sections.map((section) {
        if (section.trim().startsWith('Key Considerations:') ||
            section.trim().startsWith('Prevention Strategies:') ||
            section.trim().startsWith('Best Practices:') ||
            section.trim().startsWith('Design Guidelines:') ||
            section.trim().startsWith('Feeding Guidelines:') ||
            section.trim().startsWith('Key Breeding Practices:') ||
            section.trim().startsWith('Health Management:') ||
            section.trim().startsWith('Environmental Benefits:') ||
            section.trim().startsWith('Economic Benefits:')) {
          return _buildSectionWithBullets(context, section);
        } else if (section.trim().startsWith('Tips:')) {
          return _buildTipsSection(context, section);
        } else if (section.trim().startsWith('Warning:')) {
          return _buildWarningSection(context, section);
        } else if (section.trim().startsWith('Example:') ||
            section.trim().startsWith('Success Story:')) {
          return _buildExampleSection(context, section);
        } else {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              section,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: isDarkMode ? Colors.white70 : Colors.black87,
                height: 1.6,
              ),
            ),
          );
        }
      }).toList(),
    );
  }

  Widget _buildSectionWithBullets(BuildContext context, String section) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final lines = section.split('\n');
    final title = lines[0];
    final bullets = lines.sublist(1);

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[850] : Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.format_list_bulleted,
                color: Color(0xff6da4ed),
                size: 24,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black87,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...bullets.where((bullet) => bullet.trim().isNotEmpty).map((bullet) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    color: Color(0xff6da4ed),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      bullet.replaceAll('-', '').trim(),
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: isDarkMode ? Colors.white70 : Colors.black87,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildTipsSection(BuildContext context, String section) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? Color(0xFF2C5282).withValues(alpha: 0.3) : Color(0xFFE6F3FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb_outline, color: Colors.amber, size: 24),
              const SizedBox(width: 8),
              Text(
                'Tips',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...section.split('\n').skip(1).where((tip) => tip.trim().isNotEmpty).map(
                (tip) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.star_outline, color: Colors.amber, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      tip.replaceAll('-', '').trim(),
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: isDarkMode ? Colors.white70 : Colors.black87,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWarningSection(BuildContext context, String section) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.red[900]!.withValues(alpha: 0.3) : Colors.red[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDarkMode ? Colors.red[700]! : Colors.red[200]!,
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: Colors.red[400], size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              section.replaceAll('Warning:', '').trim(),
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: isDarkMode ? Colors.white70 : Colors.red[900],
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExampleSection(BuildContext context, String section) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.green[900]!.withValues(alpha: 0.3) : Colors.green[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDarkMode ? Colors.green[700]! : Colors.green[200]!,
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.emoji_events_outlined, color: Colors.green[400], size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              section.replaceAll('Example:', '').replaceAll('Success Story:', '').trim(),
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: isDarkMode ? Colors.white70 : Colors.green[900],
                height: 1.5,
              ),
            ),
          ),
        ],
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

const _breedingDescription = """
Successful pig breeding requires careful management and attention to detail. A well-planned breeding program can significantly increase farm profitability.

Key Breeding Practices:
- Heat Detection: Look for reddening and swelling of the vulva, restlessness, mounting other pigs, and the "standing reflex" (stands still when pressure is applied to back).
- Timing is Critical: Breed sows 12-18 hours after the first signs of standing heat for best conception rates.
- Record Keeping: Maintain detailed records of breeding dates, heat cycles, and litter performance to improve future breeding decisions.
- Proper Nutrition: Feed pregnant sows a diet with 14-16% protein and increased calcium (0.75-0.90%) during late pregnancy and lactation.

Health Management:
- Don't breed sows until they weigh at least 120-130 kg (for large breeds).
- Allow gilts (young females) to have at least 2-3 heat cycles before breeding.
- Deworm breeding stock every 3-4 months.
- Provide extra vitamins (especially A, D, and E) to breeding animals.

Tips:
- For small farms, consider artificial insemination to access better genetics without keeping a boar.
- Limit breeding during extremely hot months when fertility is reduced.
- Give sows at least 5-7 days of "flushing" (increased feed) before breeding to increase ovulation.
- Keep boars away from sows except during planned breeding to make heat detection easier.

Success Story: A small family farm in Batangas increased their average litter size from
8 to 12 piglets by implementing proper timing of breeding and improved nutrition.
""";

const _wasteDescription = """
Good waste management practices protect the environment, reduce odors, and can create additional farm income streams.

Effective Waste Management Options:
- Composting: Mix pig manure with rice husks or dried leaves (3:1 ratio) in a covered pile. Turn weekly for 45-60 days to create valuable fertilizer.
- Biogas Systems: Collect manure in sealed digesters to produce methane gas for cooking or electricity generation. A 10-pig farm can produce enough gas for basic cooking needs.
- Liquid Separation: Use simple settling tanks to separate solids from liquids. Solids can be composted while liquids can be used as crop fertilizer after dilution (1:4 with water).
- Vermiculture: Introduce earthworms to partially composted manure to create high-quality vermicompost that sells for premium prices.

Environmental Benefits:
- Prevents water pollution that can harm fish and community water sources.
- Reduces fly breeding and bad smells that cause neighbor complaints.
- Helps farms comply with environmental regulations and avoid fines.

Economic Benefits:
- A medium-sized farm can save ₱2,000-3,000 monthly on fertilizer costs.
- Biogas systems can reduce household cooking fuel expenses by 50-70%.
- Selling excess compost creates an additional income stream.

Tips:
- Start with a simple composting system and expand as you learn.
- Cover manure piles with plastic sheets to speed decomposition and prevent rain leaching.
- Apply fresh manure to fields only after composting to prevent plant burning.
- Consider partnering with nearby crop farmers to sell or trade your composted waste.

Success Story: The Mendoza family farm in Laguna built a simple biogas digester for ₱15,000 that now saves them ₱1,500 monthly on cooking gas while eliminating waste disposal problems.
""";