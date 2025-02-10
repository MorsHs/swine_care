import 'package:flutter/material.dart';
import 'package:swine_care/feature/guide/presentation/widgets/BackButton.dart';
import 'package:swine_care/feature/guide/presentation/widgets/SwineFarmingWidgets/DescriptionText.dart';
import 'package:swine_care/feature/guide/presentation/widgets/SwineFarmingWidgets/GuideItem.dart';
import 'package:swine_care/feature/guide/presentation/widgets/SwineFarmingWidgets/ImageContainer.dart';
import 'package:swine_care/feature/guide/presentation/widgets/SwineFarmingWidgets/SectionHeader.dart';

class SwineFarmingPage extends StatelessWidget {
  const SwineFarmingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BackButtonToGuidePage(),

              const SectionHeader(title: "Keeping Your Pigs Healthy"),
              const ImageContainer(imagePath: "assets/images/swinefarmingimages/youngpigs.jpg"),
              const DescriptionText(
                text: "Healthy pigs require a combination of proper management, nutrition, and disease prevention. "
                    "Key factors include:\n\n"
                    "• Stress Reduction: Overcrowding can increase disease transmission (provide at least 4m² per adult pig)\n"
                    "• Ventilation: Install proper airflow systems to prevent respiratory issues\n"
                    "• Temperature Control: Maintain 18-24°C for adult pigs using cooling/heating systems\n"
                    "• Sanitation: Implement a strict cleaning schedule for all equipment and facilities\n\n"
                    "Example: A farmer in Luzon reduced mortality rates by 40% after implementing bi-weekly pen disinfection and improving barn ventilation.",
              ),

              // Guide Items
              GuideItem(
                title: "Provide Clean Water Daily",
                description: "Pigs drink 2-5 liters daily (depending on size and weather). Use nipple drinkers to prevent contamination. \n\n"
                    "Practical Tips:\n"
                    "• Check water flow twice daily\n"
                    "• Clean troughs with vinegar solution weekly\n"
                    "• In summer, add electrolytes to water\n\n"
                    "Example: A Negros Occidental farm increased weight gain by 15% after installing automatic waterers with temperature control.",
                imagePath: "assets/images/swinefarmingimages/cleanwater.jpg",
              ),
              GuideItem(
                title: "Maintain Proper Hygiene",
                description: "Critical for preventing outbreaks:\n\n"
                    "1. Daily: Remove manure and leftover feed\n"
                    "2. Weekly: Disinfect with potassium peroxymonosulfate (1:200 dilution)\n"
                    "3. Monthly: Full pen cleaning with pressure washer\n\n"
                    "Outbreak Case Study: A Batangas farm contained cholera by immediately isolating sick pigs and implementing footbaths with 5% formalin solution.",
                imagePath: "assets/images/swinefarmingimages/hygiene.jpg",
              ),
              GuideItem(
                title: "Ensure a Balanced Diet",
                description: "Optimal feed composition:\n\n"
                    "• Growers (20-50kg): 16-18% protein, 3,200 kcal/kg\n"
                    "• Finishers (50-100kg): 14-16% protein, 3,100 kcal/kg\n"
                    "• Sows: Add 1% calcium supplement during lactation\n\n"
                    "Sample Diet:\n"
                    "Corn (60%) + Soybean Meal (25%) + Rice Bran (10%) + Premix (5%)\n\n"
                    "Warning: Avoid avocado and chocolate which are toxic to pigs",
                imagePath: "assets/images/swinefarmingimages/pigfood.jpg",
              ),
              GuideItem(
                title: "Monitor for Diseases",
                description: "Critical signs to watch:\n\n"
                    "Emergency Symptoms:\n"
                    "• Blueish ears (possible ASF)\n"
                    "• Sudden deaths with bloody diarrhea\n"
                    "• High fever (>40°C)\n\n"
                    "Prevention Protocol:\n"
                    "• Vaccinate against hog cholera every 6 months\n"
                    "• Deworm every 3 months (use ivermectin 0.3mg/kg)\n"
                    "• Quarantine new pigs for 30 days\n\n"
                    "Example: A Bulacan cooperative uses a smartphone app to track temperature readings and alert veterinarians automatically.",
                imagePath: "assets/images/swinefarmingimages/disease_monitoring.jpg",
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
