import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EmergencyMeasuresForDiseaseOutbreaks extends StatelessWidget {
  const EmergencyMeasuresForDiseaseOutbreaks({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.go('/emergency');
      },
      child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 40),
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(30),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    padding: EdgeInsets.only(top: 10, bottom: 20, left: 20),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color(0xffb0b422),
                        Color(0xffd9d367),
                        Color(0xffbeb946)
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5),
                        Container(
                          padding: EdgeInsets.all(5),
                          child: Icon(Icons.tips_and_updates_outlined),
                        ),
                        SizedBox(height: 30),
                        Text(
                          " Handling Disease Outbreaks",
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 18,
                              fontWeight: FontWeight.w300),
                        ),
                        Text(
                          "Emergency Tips for Farmers",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset("assets/images/emergency.png", height: 90, width: 100,),
              ],
            ),
          ]
      ),
    );
  }
}
