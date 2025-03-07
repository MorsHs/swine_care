import 'package:flutter/material.dart';
import 'package:swine_care/feature/guide/presentation/widgets/EmergencyTips.dart';
import 'package:swine_care/feature/guide/presentation/widgets/BestPractices.dart';
import 'package:swine_care/feature/guide/presentation/widgets/Tips&Tricks.dart';
import 'package:swine_care/feature/guide/presentation/widgets/PreventingAfricanSwineFever.dart';
import 'package:swine_care/feature/guide/presentation/widgets/SwineCareGuidesLabel.dart';
import 'package:swine_care/feature/guide/presentation/widgets/SwineCareGuidesLabel2.dart';

class GuidePage extends StatefulWidget {
  const GuidePage({super.key});

  @override
  State<GuidePage> createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            SwineCareGuidesLabel(),
            SwineCareGuidesLabel2(),
            SizedBox(height: 4),
            StartingSwineFarm(),
            SizedBox(height: 10),
            BestPractices(),
            SizedBox(height: 10),
            PreventingAfricanSwineFever(),
            SizedBox(height: 10),
            EmergencyMeasuresForDiseaseOutbreaks(),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}