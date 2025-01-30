import 'package:flutter/material.dart';
import 'package:swine_care/feature/guide/presentation/widgets/GuidePageWidgets/EmergencyMeasures.dart';
import 'package:swine_care/feature/guide/presentation/widgets/GuidePageWidgets/FarmManagement.dart';
import 'package:swine_care/feature/guide/presentation/widgets/GuidePageWidgets/StartingSwineFarm.dart';
import 'package:swine_care/feature/guide/presentation/widgets/GuidePageWidgets/DiseasePrevention.dart';
import 'package:swine_care/feature/guide/presentation/widgets/GuidePageWidgets/SwineCareGuidesLabel.dart';
import 'package:swine_care/feature/guide/presentation/widgets/GuidePageWidgets/SwineCareGuidesLabel2.dart';

class GuidePage extends StatelessWidget {
  const GuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SwineCareGuidesLabel(),
              SwineCareGuidesLabel2(),
              SizedBox(height: 4),
              StartingSwineFarm(),
              SizedBox(height: 10),
              FarmManagement(),
              SizedBox(height: 10),
              TipsToAvoidSickPigs(),
              SizedBox(height: 10),
              EmergencyMeasuresForDiseaseOutbreaks(),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
