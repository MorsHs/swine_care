import 'package:flutter/material.dart';
import 'package:swine_care/feature/guide/presentation/widgets/EmergencyMeasures.dart';
import 'package:swine_care/feature/guide/presentation/widgets/FarmManagement.dart';
import 'package:swine_care/feature/guide/presentation/widgets/StartingSwineFarm.dart';
import 'package:swine_care/feature/guide/presentation/widgets/DiseasePrevention.dart';

class GuidePage extends StatelessWidget {
  const GuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 50, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "SwineCare Guides",
                style: TextStyle(
                    color: Color(0xFFF35E7A),
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Start now mga sers",
                style: TextStyle(
                    color: Colors.black38,
                    fontSize: 16,
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(height: 10),
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
