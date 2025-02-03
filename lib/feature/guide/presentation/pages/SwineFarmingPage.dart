import 'package:flutter/material.dart';
import 'package:swine_care/feature/guide/presentation/widgets/SwineFarmingWidgets/BackButton.dart';
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

              SectionHeader(title: "Keeping Your Pigs Healthy"),
              ImageContainer(imagePath: "assets/images/swinefarmingimages/youngpigs.jpg"),
              DescriptionText(
                text: "Proper care, nutrition, and disease prevention are essential for maintaining a healthy pig farm."
                    " Ensuring pigs receive the right diet, vaccinations, and hygiene practices can prevent major diseases.",
              ),

              // Guide Items
              GuideItem(
                title: "Provide Clean Water Daily",
                description: "Always ensure your pigs have access to fresh and clean water to keep them hydrated and healthy.",
                imagePath: "assets/images/swinefarmingimages/cleanwater.jpg",
              ),
              GuideItem(
                title: "Maintain Proper Hygiene",
                description: "Regularly clean pig pens, feeders, and waterers to prevent infections and diseases.",
                imagePath: "assets/images/swinefarmingimages/hygiene.jpg",
              ),
              GuideItem(
                title: "Ensure a Balanced Diet",
                description: "Feed your pigs a mix of grains, proteins, and vitamins to promote optimal growth and health.",
                imagePath: "assets/images/swinefarmingimages/pigfood.jpg",
              ),
              GuideItem(
                title: "Monitor for Diseases",
                description: "Regularly check your pigs for symptoms of illness, and consult a veterinarian if needed.",
                imagePath: "assets/images/swinefarmingimages/disease_monitoring.jpg",
              ),

              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
