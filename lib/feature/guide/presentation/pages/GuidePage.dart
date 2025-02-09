import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:swine_care/feature/guide/presentation/widgets/GuidePageWidgets/EmergencyTips.dart';
import 'package:swine_care/feature/guide/presentation/widgets/GuidePageWidgets/BestPractices.dart';
import 'package:swine_care/feature/guide/presentation/widgets/GuidePageWidgets/Tips&Tricks.dart';
import 'package:swine_care/feature/guide/presentation/widgets/GuidePageWidgets/PreventingAfricanSwineFever.dart';
import 'package:swine_care/feature/guide/presentation/widgets/GuidePageWidgets/SwineCareGuidesLabel.dart';
import 'package:swine_care/feature/guide/presentation/widgets/GuidePageWidgets/SwineCareGuidesLabel2.dart';
import 'package:swine_care/global_widget/AdvanceDrawer.dart';

class GuidePage extends StatefulWidget {
  const GuidePage({super.key});

  @override
  State<GuidePage> createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  final _drawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    return DrawerMenu(drawerController: _drawerController,

        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
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
