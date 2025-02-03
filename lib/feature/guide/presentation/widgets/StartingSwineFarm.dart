import 'package:flutter/material.dart';

class StartingSwineFarm extends StatelessWidget {
  const StartingSwineFarm({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                      Color(0xffef729e),
                      Color(0xffec7c86),
                      Color(0xffed896d)
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
                        "Keeping Your Pigs Healthy",
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: 18,
                            fontWeight: FontWeight.w300),
                      ),
                      Text(
                        "Tips & Tricks for Swine Farming",
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
              Image.asset("assets/images/tips-and-tricks.png", height: 90, width: 100,),
            ],
          ),
        ]
    );
  }
}
