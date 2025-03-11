import 'package:flutter/material.dart';
import 'package:swine_care/colors/ArgieColors.dart';
import 'package:swine_care/feature/guide/presentation/widgets/EmergencyTips.dart';
import 'package:swine_care/feature/guide/presentation/widgets/BestPractices.dart';
import 'package:swine_care/feature/guide/presentation/widgets/Tips&Tricks.dart';
import 'package:swine_care/feature/guide/presentation/widgets/PreventingAfricanSwineFever.dart';
import 'package:swine_care/feature/guide/presentation/widgets/SwineCareGuidesLabel.dart';
import 'package:swine_care/feature/guide/presentation/widgets/SwineCareGuidesLabel2.dart';
import 'package:swine_care/colors/ArgieSizes.dart';

class GuidePage extends StatefulWidget {
  const GuidePage({super.key});

  @override
  State<GuidePage> createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section with Gradient Background
          Container(
            padding: EdgeInsets.all(ArgieSizes.paddingDefault),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ArgieColors.primary.withOpacity(isDarkMode ? 0.2 : 0.4),
                  isDarkMode ? ArgieColors.dark : Colors.grey.shade100,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const SwineCareGuidesLabel(),
                const SwineCareGuidesLabel2(),
                SizedBox(height: ArgieSizes.spaceBtwSections),
              ],
            ),
          ),

          Container(
            margin: const EdgeInsets.only(left: 20, right: 20).copyWith(bottom: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                const StartingSwineFarm(),
                SizedBox(height: ArgieSizes.spaceBtwItems),
                const BestPractices(),
                SizedBox(height: ArgieSizes.spaceBtwItems),
                const PreventingAfricanSwineFever(),
                SizedBox(height: ArgieSizes.spaceBtwItems),
                const EmergencyMeasuresForDiseaseOutbreaks(),
                SizedBox(height: ArgieSizes.spaceBtwSections),
              ],
            ),
          ),
        ],
      ),
    );
  }
}