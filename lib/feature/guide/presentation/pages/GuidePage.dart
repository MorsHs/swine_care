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

    return Scaffold(
      backgroundColor: isDarkMode ? ArgieColors.dark : ArgieColors.ligth,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              padding: const EdgeInsets.all(ArgieSizes.paddingDefault),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  SwineCareGuidesLabel(),
                  SwineCareGuidesLabel2(),
                ],
              ),
            ),

            Container(
              margin: const EdgeInsets.only(left: 20, right: 20).copyWith(bottom: 80),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SizedBox(height: 4),
                  StartingSwineFarm(),
                  SizedBox(height: ArgieSizes.spaceBtwItems),
                  BestPractices(),
                  SizedBox(height: ArgieSizes.spaceBtwItems),
                  PreventingAfricanSwineFever(),
                  SizedBox(height: ArgieSizes.spaceBtwItems),
                  EmergencyMeasuresForDiseaseOutbreaks(),
                  SizedBox(height: ArgieSizes.spaceBtwSections),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}